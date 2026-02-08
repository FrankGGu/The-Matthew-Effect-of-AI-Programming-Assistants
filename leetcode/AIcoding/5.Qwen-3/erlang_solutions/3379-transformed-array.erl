-module(transformed_array).
-export([transform/1]).

transform(Nums) ->
    N = length(Nums),
    transform(Nums, 0, N, []).

transform([], _, _, Acc) ->
    lists:reverse(Acc);
transform([H | T], I, N, Acc) ->
    Val = if
              I < N/2 -> H * H;
              true -> H * H * H
          end,
    transform(T, I + 1, N, [Val | Acc]).