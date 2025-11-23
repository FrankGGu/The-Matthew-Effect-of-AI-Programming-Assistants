-module(solution).
-export([find_max_length/1]).

find_max_length(Nums) ->
    find_max_length(Nums, 0, 0, 0).

find_max_length([], Max, _, _) ->
    Max;
find_max_length([H | T], Max, Current, Prev) ->
    if
        H > Prev ->
            find_max_length(T, max(Max, Current + 1), Current + 1, H);
        true ->
            find_max_length(T, Max, 0, H)
    end.