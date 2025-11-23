-module(solution).
-export([find_all_combinations/3]).

find_all_combinations(X, Y, Z) ->
    Sets = sets:new(),
    find_all_combinations(X, Y, Z, 0, 0, Sets).

find_all_combinations(_, _, _, A, B, Sets) when A > 1000 -> Sets;
find_all_combinations(X, Y, Z, A, B, Sets) when B > 1000 -> find_all_combinations(X, Y, Z, A + 1, 0, Sets);
find_all_combinations(X, Y, Z, A, B, Sets) ->
    Val = math:pow(X, A) + math:pow(Y, B),
    if
        Val =< Z ->
            NewSets = sets:add_element(Val, Sets),
            find_all_combinations(X, Y, Z, A, B + 1, NewSets);
        true ->
            find_all_combinations(X, Y, Z, A, B + 1, Sets)
    end.