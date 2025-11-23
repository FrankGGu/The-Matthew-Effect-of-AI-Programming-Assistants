-module(maximum_sum).
-export([maximum_sum/1]).

maximum_sum(Nums) ->
  maximum_sum(Nums, 1, length(Nums), 0, []).

maximum_sum(_Nums, N, Limit, Acc, Sums) when N > Limit ->
  lists:max(Sums);
maximum_sum(Nums, N, Limit, Acc, Sums) ->
  I = N,
  Root = round(math:sqrt(I)),
  if Root * Root =:= I ->
    maximum_sum(Nums, N + 1, Limit, Acc + lists:nth(I, Nums), [Acc + lists:nth(I, Nums)|Sums])
  ;
    true ->
      maximum_sum(Nums, N + 1, Limit, Acc, Sums)
  end.