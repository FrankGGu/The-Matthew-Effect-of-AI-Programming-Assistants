-spec sort_even_odd(Integers :: [integer()]) -> [integer()].
sort_even_odd(Integers) ->
    {EvenIndices, OddIndices} = lists:partition(fun({Index, _}) -> Index rem 2 == 0 end, lists:zip(lists:seq(0, length(Integers) - 1), Integers))),
    SortedEven = lists:sort(fun({_, A}, {_, B}) -> A =< B end, EvenIndices),
    SortedOdd = lists:sort(fun({_, A}, {_, B}) -> B =< A end, OddIndices),
    Merged = lists:merge(SortedEven, SortedOdd),
    lists:map(fun({_, Val}) -> Val end, lists:keysort(1, Merged)).