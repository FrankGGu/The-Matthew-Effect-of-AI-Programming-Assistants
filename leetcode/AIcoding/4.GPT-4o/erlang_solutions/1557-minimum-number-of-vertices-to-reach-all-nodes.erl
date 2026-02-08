-module(solution).
-export([find_smallest_set_of_vertices/1]).

find_smallest_set_of_vertices(Edges) ->
    Vertices = lists:foldl(fun({From, To}, Acc) -> 
        lists:usort([From | lists:usort(Acc)]) ++ [To]
    end, [], Edges),
    AllNodes = lists:usort(lists:map(fun({X, _}) -> X end, Edges) ++ lists:map(fun({_, Y}) -> Y end, Edges)),
    lists:filter(fun(X) -> not lists:member(X, lists:usort(Vertices)) end, AllNodes).