-module(solution).
-export([find132pattern/1]).

find132pattern(Nums) ->
    case length(Nums) < 3 of
        true -> false;
        false ->
            ReversedNums = lists:reverse(Nums),
            find_132_pattern_rec(ReversedNums, [], -1000000001)
    end.

find_132_pattern_rec([], _Stack, _KVal) ->
    false;
find_132_pattern_rec([Num_i | Rest], Stack, KVal) ->
    if Num_i < KVal ->
            true;
        true ->
            {UpdatedStack, NewKVal} = pop_and_update_k(Num_i, Stack, KVal),
            find_132_pattern_rec(Rest, [Num_i | UpdatedStack], NewKVal)
    end.

pop_and_update_k(Num, Stack, CurrentKVal) ->
    case Stack of
        [] ->
            {[], CurrentKVal};
        [Top | Rest] when Num > Top ->
            pop_and_update_k(Num, Rest, max(CurrentKVal, Top));
        _ ->
            {Stack, CurrentKVal}
    end.