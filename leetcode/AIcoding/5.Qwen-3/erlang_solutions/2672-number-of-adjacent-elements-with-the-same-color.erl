-module(solution).
-export([num_adjacent_elements_with_same_color/1]).

num_adjacent_elements_with_same_color(Colors) ->
    num_adjacent_elements_with_same_color(Colors, 0).

num_adjacent_elements_with_same_color([], _Count) ->
    0;
num_adjacent_elements_with_same_color([_], _Count) ->
    0;
num_adjacent_elements_with_same_color([A, B | Rest], Count) ->
    if
        A == B ->
            num_adjacent_elements_with_same_color([B | Rest], Count + 1);
        true ->
            num_adjacent_elements_with_same_color([B | Rest], Count)
    end.