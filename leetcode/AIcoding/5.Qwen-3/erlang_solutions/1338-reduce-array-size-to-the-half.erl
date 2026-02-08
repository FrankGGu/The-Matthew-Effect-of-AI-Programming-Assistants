-module(solution).
-export([minSetSize/1]).

minSetSize(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    Sorted = lists:reverse(lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Count))),
    minSetSize(Sorted, 0, 0).

minSetSize([], _Sum, _Size) ->
    _Size;
minSetSize([{_, C} | T], Sum, Size) ->
    if
        Sum + C >= length(Nums) div 2 + (length(Nums) rem 2 > 0) ->
            Size + 1;
        true ->
            minSetSize(T, Sum + C, Size + 1)
    end.