-module(special_permutations).
-export([special_permutation/1]).

special_permutation(Nums) ->
    N = length(Nums),
    Perms = permutations(Nums),
    lists:foldl(fun(P, Acc) -> 
        if is_special(P) -> Acc + 1;
           true -> Acc
        end
    end, 0, Perms).

permutations([]) -> [[]];
permutations(L) -> 
    [ [H | T] || H <- L, T <- permutations(lists:delete(H, L)) ].

is_special([]) -> true;
is_special([_]) -> true;
is_special([A, B | _]) when A > B -> false;
is_special([A, B | T]) -> 
    case A < B of
        true -> is_special([B | T]);
        false -> false
    end.