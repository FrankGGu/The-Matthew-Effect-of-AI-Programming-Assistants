-module(solution).
-export([top_k_frequent/2]).

top_k_frequent(List, K) ->
    FreqMap = lists:foldl(fun(X, Acc) ->
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, List),
    FreqList = maps:to_list(FreqMap),
    lists:sort(fun({_, A}, {_, B}) -> A > B end, FreqList),
    lists:map(fun({Key, _}) -> Key end, lists:sublist(FreqList, K)).