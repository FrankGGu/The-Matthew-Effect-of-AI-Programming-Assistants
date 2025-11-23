-module(minimum_number_game).
-export([number_game/1]).

number_game(Nums) ->
  lists:foldl(
    fun(X, {Acc, []}) ->
      {Acc, [X]};
       (X, {Acc, [Y]}) ->
          {Acc ++ [X, Y], []}
    end,
    {[], []},
    Nums
  ).