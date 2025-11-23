-module(solution).
-export([number_of_good_paths/2]).

number_of_good_paths(N, Values) ->
    Graph = lists:foldl(fun(X, Acc) -> dict:store(X, [], Acc) end, dict:new(), lists:seq(0, N - 1)),
    Edges = lists:foldl(fun({U, V}, Acc) -> 
        Acc1 = dict:update(U, fun(L) -> [V | L] end, [], Acc),
        dict:update(V, fun(L) -> [U | L] end, [], Acc1)
    end, Graph, lists:zip(lists:seq(0, N - 2), lists:seq(1, N - 1))),
    ValuesMap = lists:zip(lists:seq(0, N - 1), Values),
    GoodPaths = count_good_paths(Edges, ValuesMap, N),
    GoodPaths.

count_good_paths(Edges, ValuesMap, N) ->
    %% Your implementation here
    0. % Placeholder for actual implementation