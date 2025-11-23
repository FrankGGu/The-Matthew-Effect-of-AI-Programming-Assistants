-module(solution).
-export([numSquarefulArrays/1]).

numSquarefulArrays(List) ->
    Count = length(List),
    UniqueLists = lists:usort(List),
    SquarefulPerms(UniqueLists, Count, []).

SquarefulPerms([], _, Acc) ->
    case is_squareful(Acc) of
        true -> 1;
        false -> 0
    end;
SquarefulPerms(List, Count, Acc) ->
    lists:foldl(fun(X, Acc1) ->
        case lists:member(X, Acc) of
            true -> Acc1;
            false -> 
                NewAcc = [X | Acc],
                NewList = lists:delete(X, List),
                Acc1 + SquarefulPerms(NewList, Count - 1, NewAcc)
        end
    end, 0, List).

is_squareful([]) -> true;
is_squareful([_]) -> true;
is_squareful([A, B | Rest]) ->
    case is_square(A + B) of
        true -> is_squareful([B | Rest]);
        false -> false
    end.

is_square(X) ->
    S = trunc(math:sqrt(X)),
    S * S =:= X.