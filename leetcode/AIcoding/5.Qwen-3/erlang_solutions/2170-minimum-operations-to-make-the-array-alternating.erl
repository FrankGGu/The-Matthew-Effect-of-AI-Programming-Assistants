-module(min_operations).
-export([minOperations/1]).

minOperations(Nums) ->
    Len = length(Nums),
    if
        Len == 1 -> 0;
        true ->
            Count = count_freq(Nums),
            {Odd, Even} = Count,
            case length(Odd) of
                0 -> min_ops(Even, 0);
                _ -> 
                    case length(Even) of
                        0 -> min_ops(Odd, 0);
                        _ ->
                            {O1, O2} = top_two(Odd),
                            {E1, E2} = top_two(Even),
                            if
                                O1#freq.value /= E1#freq.value ->
                                    min_ops(Odd, E1#freq.count) + min_ops(Even, O1#freq.count);
                                true ->
                                    min_ops(Odd, E2#freq.count) + min_ops(Even, O1#freq.count)
                            end
                    end
            end
    end.

count_freq(Nums) ->
    count_freq(Nums, 0, dict:new(), dict:new()).

count_freq([], _, Odd, Even) ->
    {Odd, Even};
count_freq([H | T], Index, Odd, Even) ->
    case Index rem 2 of
        0 ->
            count_freq(T, Index + 1, dict:update(H, fun(V) -> V + 1 end, 1, Odd), Even);
        1 ->
            count_freq(T, Index + 1, Odd, dict:update(H, fun(V) -> V + 1 end, 1, Even))
    end.

top_two(Dict) ->
    List = dict:to_list(Dict),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, List),
    case length(Sorted) of
        0 -> {#freq{value = -1, count = 0}, #freq{value = -1, count = 0}};
        1 -> {hd(Sorted), #freq{value = -1, count = 0}};
        _ -> {hd(Sorted), nth(2, Sorted)}
    end.

min_ops(Dict, SkipCount) ->
    Total = dict:fold(fun(_, V, Acc) -> Acc + V end, 0, Dict),
    Total - SkipCount.

-record(freq, {value, count}).

nth(N, List) ->
    lists:nth(N, List).