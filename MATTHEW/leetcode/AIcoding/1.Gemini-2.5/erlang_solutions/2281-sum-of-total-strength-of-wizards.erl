-module(solution).
-export([total_strength/1]).

total_strength(StrengthList) ->
    N = length(StrengthList),
    MOD = 1000000007,

    % Convert StrengthList to an array for O(1) access
    Strength = array:from_list(StrengthList),

    % Calculate P (prefix sums)
    % P[i] = sum(Strength[0..i-1]), P[0]=0
    % P_list will be [0, s0, s0+s1, ...] length N+1
    P_list = calculate_prefix_sums(StrengthList), 

    % Calculate PP (prefix sums of prefix sums)
    % PP[i] = sum(P[0..i-1]), PP[0]=0
    % PP_list will be [0, P0, P0+P1, ...] length N+2
    PP_list = calculate_prefix_sums(P_list), 

    % Calculate L (previous smaller element index)
    % L[k] = largest p < k such that Strength[p] < Strength[k], else -1
    L = calculate_L(Strength, N), % Returns an array

    % Calculate R (next smaller or equal element index)
    % R[k] = smallest q > k such that Strength[q] <= Strength[k], else N
    R = calculate_R(Strength, N), % Returns an array

    % Calculate total strength
    lists:foldl(
        fun(K, Acc) ->
            S_k = array:get(K, Strength),
            L_k = array:get(K, L),
            R_k = array:get(K, R),

            LeftLen = K - L_k,
            RightLen = R_k - K,

            % sum_{j=k}^{R_k-1} P[j+1] = PP[R_k+1] - PP[k+1]
            Term1_sum_val = (get_at(PP_list, R_k + 1) - get_at(PP_list, K + 1)),
            Term1 = (LeftLen * Term1_sum_val) rem MOD,

            % sum_{i=L_k+1}^{k} P[i] = PP[k+1] - PP[L_k+1]
            Term2_sum_val = (get_at(PP_list, K + 1) - get_at(PP_list, L_k + 1)),
            Term2 = (RightLen * Term2_sum_val) rem MOD,

            InnerSum = (Term1 - Term2 + MOD) rem MOD,

            Contribution_K = (S_k * InnerSum) rem MOD,

            (Acc + Contribution_K) rem MOD
        end,
        0,
        lists:seq(0, N - 1)
    ).

get_at(List, Index) ->
    lists:nth(Index + 1, List).

calculate_prefix_sums(List) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(List))).

calculate_L(StrengthArray, N) ->
    L = array:new([{fixed, true}, {size, N}, {default, -1}]),
    Stack = [],
    {FinalL, _} = lists:foldl(
        fun(K, {CurrentLArray, CurrentStack}) ->
            S_k = array:get(K, StrengthArray),
            {NewStack, _} = pop_stack_until_condition(CurrentStack, StrengthArray, S_k, fun(StkVal, Val) -> StkVal >= Val end),

            L_k = case NewStack of
                      [] -> -1;
                      _ -> hd(NewStack)
                  end,

            UpdatedL = array:set(K, L_k, CurrentLArray),
            {[K | NewStack], UpdatedL}
        end,
        {L, Stack},
        lists:seq(0, N - 1)
    ),
    FinalL.

calculate_R(StrengthArray, N) ->
    R = array:new([{fixed, true}, {size, N}, {default, N}]),
    Stack = [],
    {FinalR, _} = lists:foldl(
        fun(K, {CurrentRArray, CurrentStack}) ->
            S_k = array:get(K, StrengthArray),
            {NewStack, _} = pop_stack_until_condition(CurrentStack, StrengthArray, S_k, fun(StkVal, Val) -> StkVal > Val end),

            R_k = case NewStack of
                      [] -> N;
                      _ -> hd(NewStack)
                  end,

            UpdatedR = array:set(K, R_k, CurrentRArray),
            {[K | NewStack], UpdatedR}
        end,
        {R, Stack},
        lists:seq(N - 1, 0, -1)
    ),
    FinalR.

pop_stack_until_condition(Stack, StrengthArray, Val, ConditionFun) ->
    case Stack of
        [] -> {[], undefined};
        [TopIdx | Rest] ->
            TopVal = array:get(TopIdx, StrengthArray),
            if ConditionFun(TopVal, Val) ->
                pop_stack_until_condition(Rest, StrengthArray, Val, ConditionFun);
            true ->
                {Stack, TopVal}
            end
    end.