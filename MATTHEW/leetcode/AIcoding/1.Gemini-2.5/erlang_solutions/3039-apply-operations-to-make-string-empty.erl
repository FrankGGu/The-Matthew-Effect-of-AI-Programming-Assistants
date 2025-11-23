-module(solution).
-export([solve/1]).

solve(S) ->
    solve_list(binary_to_list(S), []).

solve_list([], Acc) ->
    length(Acc);
solve_list([H|T], []) ->
    solve_list(T, [H]);
solve_list([H|T], [H|AccT]) ->
    solve_list(T, AccT);
solve_list([H|T], Acc) ->
    solve_list(T, [H|Acc]).