-module(combinations).
-export([combine/2]).

combine(N, K) ->
  combine_helper(N, K, 1, []).

combine_helper(N, 0, _, Acc) ->
  [lists:reverse(Acc)];
combine_helper(N, K, Start, Acc) when K > N - Start + 1 ->
  [];
combine_helper(N, K, Start, Acc) when K < 0 ->
  [];
combine_helper(N, K, Start, Acc) ->
  combine_helper(N, K, Start + 1, Acc) ++ combine_helper(N, K - 1, Start + 1, [Start | Acc]).