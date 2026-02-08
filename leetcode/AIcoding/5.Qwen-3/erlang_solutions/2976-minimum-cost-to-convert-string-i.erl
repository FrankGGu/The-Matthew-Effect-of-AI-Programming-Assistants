-module(solution).
-export([min_cost/2]).

min_cost(S, T) ->
    min_cost(S, T, 0, 0).

min_cost([], [], Cost, _) ->
    Cost;
min_cost([H|T1], [H|T2], Cost, _) ->
    min_cost(T1, T2, Cost, 0);
min_cost([H|T1], [H|T2], Cost, Count) ->
    min_cost(T1, T2, Cost + 1, Count + 1);
min_cost([H1|T1], [H2|T2], Cost, Count) ->
    if
        H1 == H2 ->
            min_cost(T1, T2, Cost, 0);
        true ->
            min_cost(T1, T2, Cost + 1, Count + 1)
    end.