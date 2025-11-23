-module(sum_scores).
-export([sum_scores/1]).

sum_scores(S) ->
  S_bin = list_to_binary(S),
  N = byte_size(S_bin),
  Z = z_array(S_bin),
  lists:sum(Z) + N.

z_array(S) ->
  N = byte_size(S),
  z_array(S, N, 0, 0, 1, []).

z_array(S, N, L, R, K, Acc) when K > N ->
  lists:reverse(Acc);
z_array(S, N, L, R, K, Acc) ->
  case K > R of
    true ->
      {L1, R1, ZK} = z_box(S, N, K),
      z_array(S, N, L1, R1, K + 1, [ZK | Acc]);
    false ->
      KK = K - L,
      case element(KK + 1, z_tuple(S)) < R - K + 1 of
        true ->
          ZK = element(KK + 1, z_tuple(S)),
          z_array(S, N, L, R, K + 1, [ZK | Acc]);
        false ->
          {L1, R1, ZK} = z_box(S, N, K),
          z_array(S, N, L1, R1, K + 1, [ZK | Acc])
      end
  end.

z_box(S, N, K) ->
  I = 0,
  while I + K =< N andalso binary:part(S, {0, 1}) == binary:part(S, {K + I, 1}) do
    I = I + 1
  end,
  {K, K + I - 1, I}.

z_tuple(S) ->
  N = byte_size(S),
  z_tuple(S, N, 1, []).

z_tuple(S, N, I, Acc) when I > N ->
  list_to_tuple(lists:reverse([N | Acc]));
z_tuple(S, N, I, Acc) ->
  z_tuple(S, N, I + 1, [0 | Acc]).