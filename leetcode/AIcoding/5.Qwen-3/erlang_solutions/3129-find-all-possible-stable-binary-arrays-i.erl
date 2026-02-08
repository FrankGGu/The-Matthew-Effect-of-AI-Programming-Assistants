-module(solution).
-export([find_stable_binary_arrays/1]).

find_stable_binary_arrays(N) ->
    find_stable_binary_arrays(N, 0, []).

find_stable_binary_arrays(0, _, Acc) ->
    lists:reverse(Acc);
find_stable_binary_arrays(N, Pos, Acc) ->
    case Pos of
        0 ->
            find_stable_binary_arrays(N-1, Pos+1, [[0] | Acc]);
        _ ->
            find_stable_binary_arrays(N-1, Pos+1, [[0 | hd(Acc)] | Acc])
    end.