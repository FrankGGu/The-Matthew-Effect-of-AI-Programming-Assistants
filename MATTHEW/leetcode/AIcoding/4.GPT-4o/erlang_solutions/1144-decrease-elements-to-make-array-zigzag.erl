-module(solution).
-export([moves_to_make_zigzag/1]).

moves_to_make_zigzag(Array) ->
    EvenMoves = moves_to_make_zigzag_helper(Array, 0),
    OddMoves = moves_to_make_zigzag_helper(Array, 1),
    min(EvenMoves, OddMoves).

moves_to_make_zigzag_helper(Array, Start) ->
    lists:foldl(fun({Elem, Index}, Acc) ->
        case (Index rem 2) == Start of
            true -> Acc + max(0, Elem - next_elem(Array, Index));
            false -> Acc + max(0, Elem - prev_elem(Array, Index))
        end
    end, 0, lists:zip(Array, lists:seq(0, length(Array) - 1))).

next_elem(Array, Index) ->
    case Index + 1 < length(Array) of
        true -> lists:nth(Index + 2, Array);
        false -> infinity
    end.

prev_elem(Array, Index) ->
    case Index > 0 of
        true -> lists:nth(Index, Array);
        false -> infinity
    end.

infinity -> 1#'infinity'.