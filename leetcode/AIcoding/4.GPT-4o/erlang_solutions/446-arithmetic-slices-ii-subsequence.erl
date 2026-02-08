-spec number_of_arithmetic_slices([integer()]) -> integer().
number_of_arithmetic_slices(Nums) ->
    Length = length(Nums),
    Maps = lists:duplicate(Length, #{}),
    {Result, _} = lists:foldl(
        fun(I, {Acc, MapsAcc}) ->
            {NewMapsAcc, CountI} = 
                lists:foldl(
                    fun(J, {MapsInner, CountInner}) ->
                        Diff = lists:nth(I, Nums) - lists:nth(J, Nums),
                        MapJ = lists:nth(J, MapsInner),
                        CountJ = maps:get(Diff, MapJ, 0),
                        MapI = lists:nth(I, MapsInner),
                        MapI2 = maps:put(Diff, CountJ + 1, MapI),
                        MapsInner2 = lists:substitute(I, MapI2, MapsInner),
                        {MapsInner2, CountInner + CountJ}
                    end,
                    {MapsAcc, 0},
                    lists:seq(0, I-1)
                ),
            {Acc + CountI, NewMapsAcc}
        end,
        {0, Maps},
        lists:seq(1, Length-1)
    ),
    Result.

lists:substitute(Index, Elem, List) ->
    {Left, [_|Right]} = lists:split(Index, List),
    Left ++ [Elem] ++ Right.
