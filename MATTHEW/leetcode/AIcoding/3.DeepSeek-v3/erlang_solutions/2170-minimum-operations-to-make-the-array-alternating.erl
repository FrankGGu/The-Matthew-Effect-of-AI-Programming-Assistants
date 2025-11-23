-module(solution).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
    {EvenCounts, OddCounts} = count_frequencies(Nums, #{}, #{}, 0),
    EvenSorted = sort_frequencies(EvenCounts),
    OddSorted = sort_frequencies(OddCounts),
    {MaxEven, MaxEvenCount} = get_max(EvenSorted),
    {MaxOdd, MaxOddCount} = get_max(OddSorted),
    case MaxEven =/= MaxOdd of
        true -> length(Nums) - MaxEvenCount - MaxOddCount;
        false ->
            case {EvenSorted, OddSorted} of
                {[{_, C1}], [{_, C2}]} -> min(C1, C2);
                {[{_, C1} | _], [{_, C2}, {_, C2Next} | _]} -> length(Nums) - max(C1 + C2Next, C2 + get_second_max(EvenSorted));
                {[{_, C1}, {_, C1Next} | _], [{_, C2} | _]} -> length(Nums) - max(C1Next + C2, C1 + get_second_max(OddSorted));
                _ -> 0
            end
    end.

count_frequencies([], Even, Odd, _) -> {Even, Odd};
count_frequencies([Num | Rest], Even, Odd, Index) ->
    case Index rem 2 of
        0 -> count_frequencies(Rest, maps:update_with(Num, fun(C) -> C + 1 end, 1, Even), Odd, Index + 1);
        1 -> count_frequencies(Rest, Even, maps:update_with(Num, fun(C) -> C + 1 end, 1, Odd), Index + 1)
    end.

sort_frequencies(Counts) ->
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Counts)),
    case Sorted of
        [] -> [{0, 0}];
        _ -> Sorted
    end.

get_max([{Num, Count} | _]) -> {Num, Count};
get_max([]) -> {0, 0}.

get_second_max([_, {_, Count} | _]) -> Count;
get_second_max(_) -> 0.