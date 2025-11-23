-module(minimum_length).
-export([minimum_length/1]).

minimum_length(S) ->
    minimum_length(S, 0, erlang:length(S) - 1).

minimum_length(S, Left, Right) when Left > Right ->
    0;
minimum_length(S, Left, Right) ->
    case erlang:element(Left + 1, S) of
        C when C == erlang:element(Right + 1, S) ->
            NewLeft = Left + 1,
            NewRight = Right - 1,
            if
                NewLeft > NewRight ->
                    0;
                true ->
                    minimum_length(S, NewLeft, NewRight)
            end;
        _ ->
            erlang:length(S) - Left - (erlang:length(S) - Right - 1)
    end.