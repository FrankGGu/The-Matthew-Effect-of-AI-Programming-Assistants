-module(minimum_moves_palindrome).
-export([minMoves/1]).

minMoves(S) ->
    list_to_binary(S) |> minMovesBinary().

minMovesBinary(Binary) ->
    minMovesBinary(Binary, 0).

minMovesBinary(<<>>, Acc) ->
    Acc;
minMovesBinary(<<C:8, Rest/binary>>, Acc) ->
    case binary:match(Rest, <<C:8>>) of
        nomatch ->
            minMovesBinary(Rest, Acc + (binary:length(Rest) div 2));
        {Pos, Len} ->
            NewRest = binary:part(Rest, 0, Pos) <> binary:part(Rest, Pos + Len, binary:length(Rest) - (Pos + Len)),
            minMovesBinary(NewRest, Acc + (Pos))
    end.