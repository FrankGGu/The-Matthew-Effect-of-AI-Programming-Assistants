-module(solution).
-export([min_cost/4]).

-define(INF, 1 bsl 60). % A sufficiently large number for infinity

min_cost(Num1S, Num2S, Cost1, Cost2) ->
    N1 = list_to_integer(Num1S),
    N2 = list_to_integer(Num2S),

    if N1 >= N2 ->
        0;
    true ->
        Diff = N2 - N1,
        MaxX = 19, % Check for small overshoots

        % Initialize memoization map
        Memo = maps:new(),

        % Calculate cost for Diff + 0
        {Cost0, Memo1} = calculate_cost_with_memo(Diff, Cost1, Cost2, Memo),
        MinTotalCost = Cost0,

        % Iterate through possible small overshoots (X from 1 to MaxX)
        % and update MinTotalCost
        {FinalMinCost, _} = lists:foldl(fun(X, {AccMin, AccMemo}) ->
            TargetDiff = Diff + X,
            {CostX, NewMemo} = calculate_cost_with_memo(TargetDiff, Cost1, Cost2, AccMemo),
            {min(AccMin, CostX), NewMemo}
        end, {MinTotalCost, Memo1}, lists:seq(1, MaxX)),

        FinalMinCost
    end.

calculate_cost_with_memo(D, C1, C2, Memo) ->
    case maps:find(D, Memo) of
        {ok, Cost} -> {Cost, Memo};
        _ ->
            % Mark D as currently computing to detect cycles
            MemoInProgress = maps:put(D, ?INF, Memo), % Using INF as a placeholder
            {Cost, NewMemo} = calculate_cost_recursive(D, C1, C2, MemoInProgress),
            {Cost, maps:put(D, Cost, NewMemo)} % Store the final cost
    end.

calculate_cost_recursive(0, _, _, Memo) -> {0, Memo};
calculate_cost_recursive(D, C1, C2, Memo) when D > 0 ->
    LastDigit = D rem 10,

    % Option 1: Clear the last digit using LastDigit * +1 operations.
    % The remaining difference to cover is D div 10.
    {Cost1Recursive, Memo1} = calculate_cost_with_memo(D div 10, C1, C2, Memo),
    Cost1Option = LastDigit * C1 + Cost1Recursive,

    % Option 2: Round up to the next multiple of 10.
    % This means adding (10 - LastDigit) * +1 operations,
    % then effectively adding a +10 operation (which costs C2).
    % The remaining difference to cover is (D div 10) + 1.
    TargetForOption2 = D div 10 + 1,
    {Cost2Recursive, Memo2} = case maps:find(TargetForOption2, Memo1) of
                                 {ok, ?INF} -> % Cycle detected: return INF to avoid infinite recursion
                                     {?INF, Memo1};
                                 _ ->
                                     calculate_cost_with_memo(TargetForOption2, C1, C2, Memo1)
                             end,
    Cost2Option = C2 + (10 - LastDigit) * C1 + Cost2Recursive,

    Result = min(Cost1Option, Cost2Option),
    {Result, Memo2}. % Memo2 contains updates from both recursive calls