-module(solution).
-export([find_solution/2]).

find_solution(a, b) ->
    find_solution(a, b, 1, b).

find_solution(a, b, x, max_x) when x > max_x ->
    [];

find_solution(a, b, x, max_x) ->
    if
        (b - a * x) rem x =:= 0 ->
            y = (b - a * x) div x,
            if y > 0 -> [{x, y}]; true -> find_solution(a, b, x + 1, max_x) end;
        true ->
            find_solution(a, b, x + 1, max_x)
    end.