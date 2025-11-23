-module(manhattan_distances).
-export([manhattan/1]).

manhattan(Pieces) ->
    N = length(Pieces),
    AllPerms = permutations(Pieces),
    lists:foldl(fun(Perm, Acc) -> 
        Distances = lists:zipwith(fun({X1,Y1}, {X2,Y2}) -> 
            abs(X1 - X2) + abs(Y1 - Y2) end, Perm, lists:tl(Perm)),
        lists:sum(Distances) + Acc
    end, 0, AllPerms).

permutations([]) -> [[]];
permutations(List) ->
    [ [H | T] || H <- List, T <- permutations(lists:delete(H, List)) ].