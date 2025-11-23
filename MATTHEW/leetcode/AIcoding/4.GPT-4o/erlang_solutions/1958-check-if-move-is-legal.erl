-module(solution).
-export([check_move/4]).

check_move(X, Y, NewX, NewY, Board) ->
    case lists:member({NewX, NewY}, Board) of
        false -> false;
        true ->
            (NewX > 0 andalso NewX =< 8) andalso (NewY > 0 andalso NewY =< 8) andalso
            abs(NewX - X) =< 2 andalso abs(NewY - Y) =< 2
    end.