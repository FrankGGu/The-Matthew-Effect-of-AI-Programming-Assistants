-module(earliest_and_latest_rounds).
-export([earliest_and_latest_rounds/1]).

earliest_and_latest_rounds(N) ->
  earliest_and_latest_rounds(N, 1).

earliest_and_latest_rounds(N, K) ->
  {earliest(N, K), latest(N, K)}.

earliest(N, K) ->
  earliest(N, K, 0, 1).

earliest(N, K, Round, L) when L >= K, L =< N ->
  Round;
earliest(N, K, Round, L) ->
  earliest(div(N+1, 2), div(K+1, 2), Round + 1, div(L+1, 2)).

latest(N, K) ->
  latest(N, K, 0, N).

latest(N, K, Round, R) when R =< K, R >= 1 ->
  Round;
latest(N, K, Round, R) ->
  latest(div(N+1, 2), div(N - K + 2, 2), Round + 1, div(R+1, 2)).