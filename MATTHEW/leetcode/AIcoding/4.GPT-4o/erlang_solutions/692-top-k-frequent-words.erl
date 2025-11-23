-module(solution).
-export([topKFrequent/2]).

topKFrequent(Words, K) ->
    FreqMap = lists:foldl(fun(W, Acc) ->
        maps:update_with(W, fun(Count) -> Count + 1 end, fun() -> 1 end, Acc)
    end, maps:new(), Words),
    FreqList = maps:to_list(FreqMap),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B orelse (A =:= B andalso element(1, {_, A}) < element(1, {_, B})) end, FreqList),
    lists:map(fun({Word, _}) -> Word end, lists:sublist(Sorted, K)).