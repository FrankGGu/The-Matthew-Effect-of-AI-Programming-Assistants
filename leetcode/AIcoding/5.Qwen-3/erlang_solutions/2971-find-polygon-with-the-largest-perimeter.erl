-module(solution).
-export([largest_perimeter/1]).

largest_perimeter(Nums) ->
    Sorted = lists:sort(Nums),
    find_largest(Sorted, 0).

find_largest([], _) ->
    0;
find_largest([A,B,C|T], Acc) ->
    case A + B > C of
        true ->
            find_largest([B,C|T], A + B + C);
        false ->
            find_largest([B,C|T], Acc)
    end;
find_largest([_], _) ->
    0;
find_largest([_, _], _) ->
    0.