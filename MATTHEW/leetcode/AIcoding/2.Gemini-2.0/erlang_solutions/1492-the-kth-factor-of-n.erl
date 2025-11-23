-module(kth_factor).
-export([kth_factor/2]).

kth_factor(N, K) ->
  kth_factor(N, K, 1, []).

kth_factor(N, K, I, Acc) when I > N ->
  case length(Acc) < K of
    true -> -1;
    false -> lists:nth(K, Acc)
  end;

kth_factor(N, K, I, Acc) ->
  case N rem I == 0 of
    true -> kth_factor(N, K, I + 1, Acc ++ [I]);
    false -> kth_factor(N, K, I + 1, Acc)
  end.