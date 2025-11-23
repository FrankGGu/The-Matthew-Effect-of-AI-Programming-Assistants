-module(solve).
-export([num_squares/1]).

num_squares(A) ->
    len = length(A),
    Count = 0,
    Perms = permutations(A),
    lists:foldl(fun(P, Acc) -> 
        case is_squareful(P) of
            true -> Acc + 1;
            false -> Acc
        end
    end, Count, Perms).

permutations([]) -> [[]];
permutations(L) -> 
    lists:foldl(fun(E, Acc) -> 
        lists:append([lists:append([E], P) || P <- permutations(lists:delete(E, L))], Acc)
    end, [], L).

is_squareful([]) -> true;
is_squareful([_]) -> true;
is_squareful([A, B | T]) ->
    Sqrt = math:sqrt(A * A + B * B),
    case erlang:trunc(Sqrt) == Sqrt of
        true -> is_squareful([B | T]);
        false -> false
    end.