-module(solution).
-export([add_minimum_number_of_rungs/2]).

add_minimum_number_of_rungs(Rungs, Dist) ->
    Rungs2 = [0 | Rungs],
    add_minimum_number_of_rungs_helper(Rungs2, Dist, 0, 0).

add_minimum_number_of_rungs_helper([], _, _, Count) -> 
    Count;
add_minimum_number_of_rungs_helper([_Last], _, _, Count) -> 
    Count;
add_minimum_number_of_rungs_helper([H1, H2 | T], Dist, Prev, Count) ->
    if
        H2 - H1 > Dist ->
            add_minimum_number_of_rungs_helper([H2 | T], Dist, H2, Count + ((H2 - H1 - 1) div Dist));
        true ->
            add_minimum_number_of_rungs_helper([H2 | T], Dist, H2, Count)
    end.