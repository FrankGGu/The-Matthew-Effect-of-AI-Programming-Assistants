-module(solution).
-export([min_total_distance_traveled/2]).

build_pref_R(Robots) ->
    build_pref_R(Robots, 0, [0]).

build_pref_R([], _CurrentSum, Acc) ->
    lists:reverse(Acc).
build_pref_R([H|T], CurrentSum, Acc) ->
    build_pref_R(T, CurrentSum + H, [CurrentSum + H | Acc]).

upper_bound(List, Value) ->
    upper_bound(List, Value, 0).

upper_bound([], _Value, Acc) ->
    Acc.
upper_bound([H|T], Value, Acc) when H =< Value ->
    upper_bound(T, Value, Acc+1).
upper_bound([_H|_T], _Value, Acc) ->
    Acc.

cost_func(K, I, Pj, Sj, PrefR) ->
    % Number of robots in the range [K, I-1] whose positions are <= Pj
    NumLe = min(I, Sj) - K,
    % Number of robots in the range [K, I-1] whose positions are > Pj
    NumGt = I - max(K, Sj),

    % Sum of positions for robots in [K, I-1] that are <= Pj
    SumLe = array:get(min(I, Sj), PrefR) - array:get(K, PrefR),
    % Sum of positions for robots in [K, I-1] that are > Pj
    SumGt = array:get(I, PrefR) - array:get(max(K, Sj), PrefR),

    % Total cost: sum((Pj - R_p) for R_p <= Pj) + sum((R_p - Pj) for R_p > Pj)
    Cost = (NumLe * Pj - SumLe) + (SumGt - NumGt * Pj),
    Cost.

min_total_distance_traveled(Robots0, Factories0) ->
    N = length(Robots0),

    % 1. Sort robots and factories by their positions.
    SortedRobots = lists:sort(Robots0),
    SortedFactories = lists:sort(fun({P1, _L1}, {P2, _L2}) -> P1 < P2 end, Factories0),

    % 2. Precompute prefix sums for sorted robot positions.
    PrefRList = build_pref_R(SortedRobots),
    PrefR = array:from_list(PrefRList), % array:get(k, PrefR) gives sum of first k robots

    % 3. Initialize DP table for the previous factory layer.
    % PrevDP[i] = min cost to repair first i robots using factories processed so far.
    % PrevDP[0] = 0 (0 robots, 0 cost).
    % All other PrevDP[i] are initialized to infinity.
    Infinity = float('infinity'),
    InitialPrevDPList = [0] ++ lists:duplicate(N, Infinity),
    PrevDP = array:from_list(InitialPrevDPList),

    % Iterate through each factory, applying D&C optimization for DP transition.
    FinalDP = lists:foldl(
        fun({Pj, Lj}, AccPrevDP) ->
            % CurrDP will store dp values for the current factory layer.
            CurrDPList = [0] ++ lists:duplicate(N, Infinity),
            CurrDP = array:from_list(CurrDPList),

            % Sj: the index of the first robot whose position is > Pj.
            % (i.e., count of robots with position <= Pj)
            Sj = upper_bound(SortedRobots, Pj),

            % Call the D&C optimization solver.
            % It computes CurrDP[i] for i from 1 to N.
            solve_dc(1, N, 0, N, Pj, Lj, Sj, PrefR, AccPrevDP, CurrDP)
        end,
        PrevDP,
        SortedFactories
    ),

    % The final answer is the minimum cost to repair all N robots.
    array:get(N, FinalDP).

solve_dc(IStart, IEnd, KStart, KEnd, Pj, Lj, Sj, PrefR, PrevDP, CurrDP) ->
    if IStart > IEnd ->
        CurrDP; % Base case: invalid range, return current DP array.
    true ->
        Mid = IStart + (IEnd - IStart) div 2, % Midpoint of the current robot count range.

        % Determine the valid range for k (previous robot count).
        % k must be at least KStart (from parent call) and at least Mid - Lj (factory limit).
        KLow = max(KStart, Mid - Lj),
        % k must be at most KEnd (from parent call) and at most Mid - 1 (k < i).
        KHigh = min(Mid - 1, KEnd),

        % Find the best k for CurrDP[Mid].
        % Initialize with infinity and -1 (no best k found yet).
        {FoundMinCost, FoundBestK} = find_best_k(KLow, KHigh, Mid, Pj, Lj, Sj, PrefR, PrevDP, float('infinity'), -1),

        % Update CurrDP with the computed value for Mid.
        UpdatedCurrDP = array:set(Mid, FoundMinCost, CurrDP),

        % Recursively solve for the left and right subproblems.
        % The k range for children is tightened based on FoundBestK.
        LeftUpdatedDP = solve_dc(IStart, Mid-1, KStart, FoundBestK, Pj, Lj, Sj, PrefR, PrevDP, UpdatedCurrDP),
        RightUpdatedDP = solve_dc(Mid+1, IEnd, FoundBestK, KEnd, Pj, Lj, Sj, PrefR, PrevDP, LeftUpdatedDP),
        RightUpdatedDP
    end.

find_best_k(K, KHigh, Mid, Pj, Lj, Sj, PrefR, PrevDP, CurrentMinCost, CurrentBestK) when K =< KHigh ->
    PrevDPK = array:get(K, PrevDP),
    if PrevDPK == float('infinity') ->
        % If PrevDP[K] is infinity, this path is not viable.
        find_best_k(K+1, KHigh, Mid, Pj, Lj, Sj, PrefR, PrevDP, CurrentMinCost, CurrentBestK);
    true ->
        Cost = cost_func(K, Mid, Pj, Sj, PrefR),
        TotalCost = PrevDPK + Cost,
        if TotalCost < CurrentMinCost ->
            % Found a better cost, update min cost and best k.
            find_best_k(K+1, KHigh, Mid, Pj, Lj, Sj, PrefR, PrevDP, TotalCost, K);
        true ->
            % Current k does not yield a better cost.
            find_best_k(K+1, KHigh, Mid, Pj, Lj, Sj, PrefR, PrevDP, CurrentMinCost, CurrentBestK)
        end
    end;
find_best_k(_K, _KHigh, _Mid, _Pj, _Lj, _Sj, _PrefR, _PrevDP, CurrentMinCost, CurrentBestK) ->
    % Base case: K has exceeded KHigh, return the best found so far.
    {CurrentMinCost, CurrentBestK}.

max(A, B) when A > B -> A;
max(A, B) -> B.

min(A, B) when A < B -> A;
min(A, B) -> B.