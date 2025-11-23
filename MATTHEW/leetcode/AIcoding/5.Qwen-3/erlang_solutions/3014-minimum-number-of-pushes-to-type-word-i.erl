-module(minimum_number_of_pushes).
-export([minimumPushes/1]).

minimumPushes(Word) ->
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Word),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Count)),
    lists:foldl(fun({Char, C}, {Res, N}) ->
        if
            N < 8 -> {Res + C * 1, N + 1};
            N < 16 -> {Res + C * 2, N + 1};
            N < 24 -> {Res + C * 3, N + 1};
            true -> {Res + C * 4, N + 1}
        end
    end, {0, 1}, Sorted).