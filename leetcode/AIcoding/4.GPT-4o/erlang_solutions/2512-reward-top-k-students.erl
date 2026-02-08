-module(solution).
-export([topKFrequent/2]).

topKFrequent(Students, K) ->
    FrequencyMap = maps:fold(fun(Student, Acc) -> maps:update_with(Student, fun(X) -> X + 1 end, 1, Acc) end, maps:new(), Students),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(FrequencyMap)),
    TopK = lists:map(fun({Student, _}) -> Student end, lists:sublist(Sorted, K)),
    TopK.