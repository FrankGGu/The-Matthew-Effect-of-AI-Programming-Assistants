-module(max_sales).
-export([max_sales/2]).

max_sales(Sales, K) ->
  max_sales_helper(Sales, K, 0, 0).

max_sales_helper([], _, MaxSum, CurrentSum) ->
  max(MaxSum, CurrentSum);
max_sales_helper(Sales, K, MaxSum, CurrentSum) when length(Sales) < K ->
  max(MaxSum, CurrentSum);
max_sales_helper(Sales, K, MaxSum, CurrentSum) ->
  {Prefix, Suffix} = lists:split(K, Sales),
  NewCurrentSum = lists:sum(Prefix),
  NewMaxSum = max(MaxSum, NewCurrentSum),
  max_sales_helper(Suffix, K, NewMaxSum, NewCurrentSum).

max(A, B) ->
  if A > B ->
    A;
  true ->
    B
  end.