-module(stone_game_viii).
-export([stone_game_viii/1]).

stone_game_viii(Stones) ->
  N = length(Stones),
  PrefixSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Stones)),
  PrefixSumRev = lists:reverse(PrefixSum),

  Memo = dict:new(),

  F = fun(I, M) ->
        case dict:find( {I, N}, M) of
          {ok, Value} ->
            Value;
          error ->
            if I == N then
              0
            else
              Res = PrefixSumRev[I+2] - lists:min([F(J, dict:store({J, N}, V, M)) || J <- lists:seq(I+1, N-1), V = F(J, dict:store({J, N}, 0, M))]),
              dict:store({I, N}, Res, M)
            end
        end
      end,

  F(0, Memo).