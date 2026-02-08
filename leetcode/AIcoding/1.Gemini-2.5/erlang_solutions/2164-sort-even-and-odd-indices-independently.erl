-module(solution).
-export([sort_even_odd_independently/1]).

sort_even_odd_independently(Nums) ->
    {EvenElements, OddElements} = separate_by_index(Nums, 0, [], []),
    SortedEven = lists:sort(EvenElements),
    SortedOdd = lists:reverse(lists:sort(OddElements)),
    merge_alternately(SortedEven, SortedOdd, []).

separate_by_index([], _Idx, AccEven, AccOdd) ->
    {lists:reverse(AccEven), lists:reverse(AccOdd)};
separate_by_index([H|T], Idx, AccEven, AccOdd) when Idx rem 2 == 0 ->
    separate_by_index(T, Idx + 1, [H|AccEven], AccOdd);
separate_by_index([H|T], Idx, AccEven, AccOdd) ->
    separate_by_index(T, Idx + 1, AccEven, [H|AccOdd]).

merge_alternately([], [], Acc) ->
    lists:reverse(Acc);
merge_alternately([HE|TE], [], Acc) ->
    lists:reverse(Acc) ++ [HE|TE];
merge_alternately([], [HO|TO], Acc) ->
    lists:reverse(Acc) ++ [HO|TO];
merge_alternately([HE|TE], [HO|TO], Acc) ->
    merge_alternately(TE, TO, [HO, HE|Acc]).