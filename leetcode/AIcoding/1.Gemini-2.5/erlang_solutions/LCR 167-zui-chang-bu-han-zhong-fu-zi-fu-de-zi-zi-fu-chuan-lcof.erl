-module(solution).
-export([solve/1]).

solve(S) ->
    solve_recursive(S, #{}, []).

solve_recursive([], _SeenMap, Acc) ->
    lists:reverse(Acc).
solve_recursive([H|T], SeenMap, Acc) ->
    case maps:is_key(H, SeenMap) of
        true ->
            solve_recursive(T, SeenMap, Acc);
        false ->
            solve_recursive(T, maps:put(H, true, SeenMap), [H|Acc])
    end.