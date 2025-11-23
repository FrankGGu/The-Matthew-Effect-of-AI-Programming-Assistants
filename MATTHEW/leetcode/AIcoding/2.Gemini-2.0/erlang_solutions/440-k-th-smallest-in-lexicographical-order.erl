-module(kth_smallest_lexicographical).

-export([findKthNumber/2]).

findKthNumber(N, K) ->
  findKthNumber(N, K, 1).

findKthNumber(N, K, Curr) ->
  if K =:= 1 ->
    Curr
  else
    Steps = getSteps(N, Curr, Curr + 1),
    if Steps >= K ->
      findKthNumber(N, K - 1, Curr * 10)
    else
      findKthNumber(N, K - Steps, Curr + 1)
    end
  end.

getSteps(N, N1, N2) ->
  Steps = 0,
  Limit = N + 1,
  while N1 < Limit do
    Steps = Steps + min(Limit, N2) - N1,
    N1 = N1 * 10,
    N2 = N2 * 10
  end,
  Steps.