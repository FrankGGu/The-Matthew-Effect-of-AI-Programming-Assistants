-module(solution).
-export([count_collisions/1]).

count_collisions(steps) ->
    count_collisions(steps, 0, 0).

count_collisions([], current_count, total_count) ->
    total_count;
count_collisions([H | T], current_count, total_count) ->
    NewCount = case H of
        1 -> current_count + 1;
        2 -> current_count - 1;
        _ -> current_count
    end,
    count_collisions(T, NewCount, total_count + abs(NewCount)).