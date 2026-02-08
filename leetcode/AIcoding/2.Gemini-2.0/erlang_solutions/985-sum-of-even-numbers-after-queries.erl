-module(solution).
-export([sum_even_after_queries/2]).

sum_even_after_queries(A, Queries) ->
  sum_even_after_queries(A, Queries, []).

sum_even_after_queries(_A, [], Acc) ->
  lists:reverse(Acc);
sum_even_after_queries(A, [Query | Rest], Acc) ->
  [Val, Index] = Query,
  OldVal = lists:nth(Index + 1, A),
  NewVal = OldVal + Val,
  NewA = lists:replace(Index + 1, NewVal, A),
  SumEven = lists:sum([X || X <- NewA, X rem 2 =:= 0]),
  sum_even_after_queries(NewA, Rest, [SumEven | Acc]).