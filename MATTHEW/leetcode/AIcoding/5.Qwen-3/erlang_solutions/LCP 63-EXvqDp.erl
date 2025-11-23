-module(solution).
-export([ball_game/1]).

ball_game(Balls) ->
    ball_game(Balls, 0).

ball_game([], _Index) ->
    0;
ball_game([H | T], Index) ->
    case H of
        0 ->
            ball_game(T, Index + 1);
        _ ->
            if
                Index rem 2 == 0 ->
                    ball_game(T, Index + 1);
                true ->
                    ball_game(T, Index + 1)
            end
    end.