-module(solution).
-export([possibly_original/2]).

possibly_original(S, T) ->
    possibly_original(S, T, 0, 0, 1).

possibly_original([], [], _, _, _) -> true;
possibly_original(_, [], _, _, _) -> false;
possibly_original([], _, _, _, _) -> false;

possibly_original(S, T, I, J, K) ->
    case S -- [I] of
        [C | _] when C == T -- [J] ->
            possibly_original(S, T, I + 1, J + 1, K);
        _ ->
            possibly_original(S, T, I, J, K + 1)
    end.

possibly_original(S, T, I, J, K) when K > 1 ->
    case S -- [I] of
        [C | _] when C == T -- [J] ->
            possibly_original(S, T, I + 1, J + 1, K);
        _ ->
            possibly_original(S, T, I, J, K - 1)
    end.

possibly_original(S, T, I, J, K) ->
    possibly_original(S, T, I, J, K + 1).