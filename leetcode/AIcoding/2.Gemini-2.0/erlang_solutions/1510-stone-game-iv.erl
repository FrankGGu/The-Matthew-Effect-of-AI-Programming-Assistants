-module(stone_game_iv).
-export([winner_square_game/1]).

winner_square_game(n) ->
    winner_square_game(n, dict:new()).

winner_square_game(0, _) -> false;
winner_square_game(N, Memo) ->
    case dict:find(N, Memo) of
        {ok, Result} ->
            Result;
        error ->
            Result = can_win(N, Memo),
            NewMemo = dict:store(N, Result, Memo),
            Result
    end.

can_win(N, Memo) ->
    lists:any(fun(X) ->
                      not winner_square_game(N - X * X, Memo)
              end,
              [X || X <- lists:seq(1, trunc(math:sqrt(N))) ]).