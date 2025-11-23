-module(solution).
-export([lexicographically_smallest_string/1]).

lexicographically_smallest_string(N) ->
    lexicographically_smallest_string(N, 0, []).

lexicographically_smallest_string(0, _, Acc) ->
    lists:reverse(Acc);
lexicographically_smallest_string(N, Pos, Acc) ->
    case Pos rem 2 of
        0 ->
            lexicographically_smallest_string(N - 1, Pos + 1, [$a | Acc]);
        1 ->
            lexicographically_smallest_string(N - 1, Pos + 1, [$b | Acc])
    end.