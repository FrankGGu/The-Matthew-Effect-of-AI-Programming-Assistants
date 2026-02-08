-module(solution).
-export([minimum_deletion_size/1]).

minimum_deletion_size(Strs) ->
    Counts = lists:map(fun(S) -> string:to_integer(S) end, lists:map(fun(S) -> lists:map(fun(C) -> C - $a end, unicode:characters_to_list(S)) end, Strs)),
    lists:foldl(fun({A, B}, Acc) -> 
        lists:foldl(fun({C, D}, Acc2) -> 
            if C > D -> Acc2 + 1; true -> Acc2 end 
        end, Acc, lists:zip(A, B))
    end, 0, lists:zip(Counts, tl(Counts))).