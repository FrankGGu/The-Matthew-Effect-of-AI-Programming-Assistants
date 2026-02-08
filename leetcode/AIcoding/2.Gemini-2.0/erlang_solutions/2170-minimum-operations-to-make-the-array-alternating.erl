-module(min_operations_alternating).
-export([min_operations/1]).

min_operations(Nums) ->
    Len = length(Nums),
    {First, Second} = lists:foldl(
        fun(Num, {Map1, Map2}) ->
            case maps:is_key(Num, Map1) of
                true ->
                    NewMap1 = maps:update(Num, maps:get(Num, Map1) + 1, Map1);
                false ->
                    NewMap1 = maps:put(Num, 1, Map1)
            end,
            case maps:is_key(Num, Map2) of
                true ->
                    NewMap2 = maps:update(Num, maps:get(Num, Map2) + 1, Map2);
                false ->
                    NewMap2 = maps:put(Num, 1, Map2)
            end,
            {NewMap1, NewMap2}
        end,
        {#{}, #{}},
        lists:zipwith(fun(Idx, Num) -> {Idx, Num} end, lists:seq(1, Len), Nums)
    ),

    Odds = lists:foldl(
        fun({Idx, Num}, Acc) ->
            case (Idx rem 2) == 1 of
                true ->
                    [Num|Acc];
                false ->
                    Acc
            end
        end,
        [],
        lists:zipwith(fun(Idx, Num) -> {Idx, Num} end, lists:seq(1, Len), Nums)
    ),

    Evens = lists:foldl(
        fun({Idx, Num}, Acc) ->
            case (Idx rem 2) == 0 of
                true ->
                    [Num|Acc];
                false ->
                    Acc
            end
        end,
        [],
        lists:zipwith(fun(Idx, Num) -> {Idx, Num} end, lists:seq(1, Len), Nums)
    ),

    {OddMap, EvenMap} = lists:foldl(
        fun(Num, {Map1, Map2}) ->
            case maps:is_key(Num, Map1) of
                true ->
                    NewMap1 = maps:update(Num, maps:get(Num, Map1) + 1, Map1);
                false ->
                    NewMap1 = maps:put(Num, 1, Map1)
            end,
            case maps:is_key(Num, Map2) of
                true ->
                    NewMap2 = maps:update(Num, maps:get(Num, Map2) + 1, Map2);
                false ->
                    NewMap2 = maps:put(Num, 1, Map2)
            end,
            {NewMap1, NewMap2}
        end,
        {#{}, #{}},
        {Odds, Evens}
    ),

    sorted_odd_counts(OddMap,OddCounts),
    sorted_even_counts(EvenMap,EvenCounts),

    TopOdd = lists:nth(1,OddCounts),
    TopEven = lists:nth(1,EvenCounts),

    TopOddValue = element(1,TopOdd),
    TopOddCount = element(2,TopOdd),
    TopEvenValue = element(1,TopEven),
    TopEvenCount = element(2,TopEven),

    case TopOddValue /= TopEvenValue of
        true ->
            Len - TopOddCount - TopEvenCount;
        false ->
            case length(OddCounts) > 1 and length(EvenCounts) > 1 of
                true ->
                    SecondOdd = lists:nth(2,OddCounts),
                    SecondEven = lists:nth(2,EvenCounts),
                    SecondOddCount = element(2,SecondOdd),
                    SecondEvenCount = element(2,SecondEven),
                    Min1 = Len - TopOddCount - SecondEvenCount,
                    Min2 = Len - SecondOddCount - TopEvenCount,
                    min(Min1,Min2);
                false ->
                    Len div 2 
            end
    end.

sorted_odd_counts(OddMap,Result) ->
    map_to_sorted_list(OddMap, OddSorted),
    lists:reverse(lists:sort(fun({_, V1}, {_, V2}) -> V1 > V2 end, OddSorted)),
    Result = OddSorted.

sorted_even_counts(EvenMap,Result) ->
    map_to_sorted_list(EvenMap, EvenSorted),
    lists:reverse(lists:sort(fun({_, V1}, {_, V2}) -> V1 > V2 end, EvenSorted)),
    Result = EvenSorted.

map_to_sorted_list(Map, List) ->
    List = maps:to_list(Map).