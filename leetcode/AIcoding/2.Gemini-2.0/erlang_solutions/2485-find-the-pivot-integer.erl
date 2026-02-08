-module(find_pivot_integer).
-export([pivot_integer/1]).

pivot_integer(N) ->
  Sum = (N * (N + 1)) div 2,
  pivot_integer(N, Sum, 0).

pivot_integer(_N, Sum, Sum) ->
  _N;
pivot_integer(N, TotalSum, LeftSum) ->
  CurrentSum = N,
  NewLeftSum = LeftSum + N,
  NewTotalSum = TotalSum - N,
  if NewLeftSum == NewTotalSum ->
    N;
  true ->
    if N == 1 ->
      -1;
    true ->
      pivot_integer(N - 1, TotalSum, NewLeftSum)
    end
  end.