-module(solution).
-export([max_subarray_product_equal/1]).

max_subarray_product_equal(Nums) ->
    N = length(Nums),
    if N < 2 -> 0;
       true -> solve(Nums, N)
    end.

solve(Nums, N) ->
    PrefixLogSums = calculate_prefix_log_sums(Nums),

    AllSubarrays = generate_all_subarrays_data(PrefixLogSums, N),

    SortedSubarrays = lists:sort(fun({S1, _, _}, {S2, _, _}) -> S1 =< S2 end, AllSubarrays),

    MaxLen = find_max_length(SortedSubarrays).

calculate_prefix_log_sums(Nums) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> [hd(Acc) + math:log(X) | Acc] end, [0.0], Nums)).

generate_all_subarrays_data(PrefixLogSums, N) ->
    lists:flatten([
        [ {lists:nth(J+2, PrefixLogSums) - lists:nth(I+1, PrefixLogSums), I, J}
          || J <- lists:seq(I, N-1) ]
        || I <- lists:seq(0, N-1)
    ]).

find_max_length(SortedSubarrays) ->
    Epsilon = 1.0e-9,

    GroupedSubarrays = group_by_log_sum(SortedSubarrays, Epsilon),

    lists:foldl(fun(Group, AccMaxLen) ->
        GroupMaxLen = find_max_len_in_group_optimized(Group),
        max(AccMaxLen, GroupMaxLen)
    end, 0, GroupedSubarrays).

group_by_log_sum([], _Epsilon) -> [];
group_by_log_sum([H | T], Epsilon) ->
    group_by_log_sum_acc(H, T, Epsilon, [H], []).

group_by_log_sum_acc({S_curr, _, _} = CurrentH, [], _Epsilon, CurrentGroup, AccGroups) ->
    lists:reverse([lists:reverse(CurrentGroup) | AccGroups]);
group_by_log_sum_acc({S_curr, _, _} = CurrentH, [{S_next, _, _} = NextH | T], Epsilon, CurrentGroup, AccGroups) ->
    if abs(S_curr - S_next) < Epsilon ->
        group_by_log_sum_acc(NextH, T, Epsilon, [NextH | CurrentGroup], AccGroups);
    true ->
        group_by_log_sum_acc(NextH, T, Epsilon, [NextH], [lists:reverse(CurrentGroup) | AccGroups])
    end.

find_max_len_in_group_optimized(Group) ->
    SortedGroup = lists:sort(fun({_, I1, _}, {_, I2, _}) -> I1 =< I2 end, Group),
    M = length(SortedGroup),

    if M < 2 -> 0;
       true ->
            MinEndBefore = calculate_min_end_before_list(SortedGroup),
            MaxStartAfter = calculate_max_start_after_list(SortedGroup),

            element(2, lists:foldl(fun({_S, I, J}, {Idx, CurrentMaxL}) ->
                L = J - I + 1,
                MinJPrev = lists:nth(Idx + 1, MinEndBefore),
                MaxINext = lists:nth(Idx + 1, MaxStartAfter),

                CandidateL = if (MinJPrev < I) or (MaxINext > J) -> L;
                               true -> 0
                            end,
                {Idx + 1, max(CurrentMaxL, CandidateL)}
            end, {0, 0}, SortedGroup))
    end.

calculate_min_end_before_list(SortedGroup) ->
    element(2, lists:foldl(fun({_, _, J}, {MinSoFar, Acc}) ->
        {min(MinSoFar, J), Acc ++ [MinSoFar]}
    end, {infinity, []}, SortedGroup)).

calculate_max_start_after_list(SortedGroup) ->
    element(2, lists:foldr(fun({_, I, _}, {MaxSoFar, Acc}) ->
        {max(MaxSoFar, I), [MaxSoFar | Acc]}
    end, {-1, []}, SortedGroup)).