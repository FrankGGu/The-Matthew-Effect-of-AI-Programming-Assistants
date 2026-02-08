-module(maximize_value).
-export([maximum_value/2]).

maximum_value(P, Value) ->
  N = length(P),
  LogN = floor(math:log2(N)) + 1,
  DP = array:new([N + 1, LogN + 1]),
  init_dp(P, DP, N, LogN),
  foldl(fun(X, Acc) ->
            Acc + X
        end, 0, Value).

init_dp(P, DP, N, LogN) ->
  init_dp_helper(P, DP, N, LogN, 0).

init_dp_helper(P, DP, N, LogN, I) when I < N ->
  array:set({I, 0}, lists:nth(I + 1, P) - 1, DP),
  init_dp_helper(P, DP, N, LogN, I + 1);
init_dp_helper(_P, DP, N, LogN, N) ->
  fill_dp(DP, N, LogN, 1).

fill_dp(DP, N, LogN, J) when J < LogN ->
  fill_dp_helper(DP, N, LogN, J, 0),
  fill_dp(DP, N, LogN, J + 1);
fill_dp(_DP, _N, _LogN, _J) ->
  ok.

fill_dp_helper(DP, N, LogN, J, I) when I < N ->
  Prev = array:get({I, J - 1}, DP),
  array:set({I, J}, array:get({Prev, J - 1}, DP), DP),
  fill_dp_helper(DP, N, LogN, J, I + 1);
fill_dp_helper(_DP, _N, _LogN, _J, _I) ->
  ok.