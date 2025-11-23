-module(solution).
-export([find_all_possible_stable_binary_arrays/1]).

find_all_possible_stable_binary_arrays(N) ->
    find_arrays(N, 0, []).

find_arrays(0, _, Acc) -> 
    [lists:reverse(Acc)];
find_arrays(N, 1, Acc) -> 
    find_arrays(N - 1, 0, [1 | Acc]);
find_arrays(N, 0, Acc) -> 
    find_arrays(N - 1, 1, [0 | Acc]);
find_arrays(N, State, Acc) ->
    case State of
        0 -> 
            find_arrays(N - 1, 1, [0 | Acc]);
        1 -> 
            find_arrays(N - 1, 0, [1 | Acc])
    end.