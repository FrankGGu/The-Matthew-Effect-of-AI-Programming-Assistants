-module(solution).
-export([min_time/3]).

min_time(N, Rides, ChangeTime) ->
    % Step 1: Initialize f array (min time for k laps using a single ride)
    % f[k] = min time for k laps with one ride
    % Initialize f with a large value (infinity)
    % Max possible dp value is ~10^16, so 10^18 is a safe infinity.
    Infinity = 1000000000000000000,
    F = array:new([{size, N + 1}, {fixed, true}, {default, Infinity}]),
    F_init = array:set(0, 0, F), % f[0] is not directly used for laps, but for DP base case.

    % Calculate f[k] for k=1 to N
    F_computed = lists:foldl(
        fun([C, T], CurrentF) ->
            CurrentCost = C,
            % Use a tail-recursive helper to iterate k and break early
            calculate_f_for_ride(1, N, CurrentCost, T, CurrentF)
        end,
        F_init,
        Rides
    ),

    % Step 2: Create A array (cost for k laps, including change_time)
    % A[k] = f[k] + ChangeTime (for k < i)
    % A[0] = 0
    A = array:new([{size, N + 1}, {fixed, true}, {default, Infinity}]),
    A_init = array:set(0, 0, A),
    A_computed = lists:foldl(
        fun(K, AccA) ->
            FK = array:get(K, F_computed),
            array:set(K, FK + ChangeTime, AccA)
        end,
        A_init,
        lists:seq(1, N)
    ),

    % Step 3: Initialize dp array
    % dp[i] = min time to finish i laps
    DP = array:new([{size, N + 1}, {fixed, true}, {default, Infinity}]),
    DP_init = array:set(0, 0, DP),

    % Step 4: Use a deque for CHT optimization
    % Deque stores indices j. Implemented using two lists for O(1) amortized operations.
    % {FrontList, ReversedBackList}
    DQ = {[0], []}, % Initial deque contains only 0

    % Compute dp[i] for i = 1 to N
    {_FinalDQ, FinalDP} = lists:foldl(
        fun(I, {CurrentDQ, CurrentDP}) ->
            % Option 1: Use a single ride for all I laps (cost is f[I])
            CurrentDPI = array:get(I, F_computed),
            UpdatedDP_with_fI = array:set(I, CurrentDPI, CurrentDP),

            % Option 2: Use a previous state dp[j] and switch to a ride for I-j laps
            % Remove elements from front of deque that are no longer optimal
            {DQ_after_front_pop, J_opt} = pop_front_redundant(CurrentDQ, I, UpdatedDP_with_fI, A_computed),

            MinValFromDeque = case J_opt of
                undefined -> Infinity;
                J ->
                    DPJ = array:get(J, UpdatedDP_with_fI),
                    A_IK = array:get(I - J, A_computed),
                    DPJ + A_IK
            end,

            UpdatedDPI_val = array:get(I, UpdatedDP_with_fI),
            UpdatedDPI_val_min = min(UpdatedDPI_val, MinValFromDeque),
            UpdatedDP_with_min = array:set(I, UpdatedDPI_val_min, UpdatedDP_with_fI),

            % Remove elements from back of deque that become redundant after adding I
            DQ_after_back_pop = pop_back_redundant(DQ_after_front_pop, I, UpdatedDP_with_min),

            % Add I to the back of the deque
            NewDQ = push_back(DQ_after_back_pop, I),

            {NewDQ, UpdatedDP_with_min}
        end,
        {DQ, DP_init}, % Start with DQ = {[0], []} and DP_init
        lists:seq(1, N)
    ),

    array:get(N, FinalDP).

calculate_f_for_ride(K, MaxK, CurrentCost, T, AccF) when K =< MaxK ->
    OldFK = array:get(K, AccF),
    If CurrentCost >= OldFK ->
        AccF; % Break early
    true ->
        NewAccF = array:set(K, CurrentCost, AccF),
        calculate_f_for_ride(K + 1, MaxK, CurrentCost + T, T, NewAccF)
    End;
calculate_f_for_ride(_K, _MaxK, _CurrentCost, _T, AccF) ->
    AccF.

push_front({Front, Back}, Elem) -> {[Elem | Front], Back}.
pop_front({[], Back}) -> pop_front({lists:reverse(Back), []});
pop_front({[H|T], Back}) -> {H, {T, Back}}.
peek_front({[], Back}) -> peek_front({lists:reverse(Back), []});
peek_front({[H|_], _}) -> H.

push_back({Front, Back}, Elem) -> {Front, [Elem | Back]}.
pop_back({Front, []}) -> pop_back({[], lists:reverse(Front)});
pop_back({Front, [H|T]}) -> {H, {Front, T}}.
peek_back({Front, []}) -> peek_back({[], lists:reverse(Front)});
peek_back({_, [H|_]}) -> H.

len({Front, Back}) -> length(Front) + length(Back).

pop_front_redundant(DQ, I, DP, A) ->
    case len(DQ) of
        L when L < 2 -> {DQ, peek_front(DQ)};
        _ ->
            J1 = peek_front(DQ),
            J2 = peek_front(pop_front(DQ)), % Peek at second element without modifying DQ

            DP_J1 = array:get(J1, DP),
            DP_J2 = array:get(J2, DP),

            A_IK1 = array:get(I - J1, A),
            A_IK2 = array:get(I - J2, A),

            If DP_J1 + A_IK1 >= DP_J2 + A_IK2 ->
                pop_front_redundant(pop_front(DQ), I, DP, A);
            true ->
                {DQ, J1} % J1 is optimal, return original DQ and J1
            End
    end.

pop_back_redundant(DQ, I, DP) ->
    case len(DQ) of
        L when L < 2 -> DQ;
        _ ->
            J_last = peek_back(DQ),
            J_second_last = peek_back(pop_back(DQ)),

            DP_J_second_last = array:get(J_second_last, DP),
            DP_J_last = array:get(J_last, DP),
            DP_I = array:get(I, DP),

            % Convexity check: (dp[j_last] - dp[j_second_last]) * (i - j_last) >= (dp[i] - dp[j_last]) * (j_last - j_second_last)
            % This checks if point J_last is redundant given J_second_last and I
            Val1 = (DP_J_last - DP_J_second_last) * (I - J_last),
            Val2 = (DP_I - DP_J_last) * (J_last - J_second_last),

            If Val1 >= Val2 ->
                % J_last is redundant, remove it
                pop_back_redundant(pop_back(DQ), I, DP);
            true ->
                DQ % J_last is not redundant
            End
    end.