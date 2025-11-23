-module(stable_binary_arrays).
-export([find_stable_arrays/1]).

find_stable_arrays(N) ->
    find_stable_arrays(N, 0, []).

find_stable_arrays(0, _, Acc) ->
    lists:reverse(Acc);
find_stable_arrays(N, State, Acc) ->
    case State of
        0 ->
            find_stable_arrays(N-1, 1, [[0] | Acc]);
        1 ->
            find_stable_arrays(N-1, 0, [[1] | Acc]),
            find_stable_arrays(N-1, 1, [[0,1] | Acc]);
        _ ->
            find_stable_arrays(N-1, 0, [[1] | Acc])
    end.