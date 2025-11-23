-module(fair_candy_swap).
-export([fair_candy_swap/2]).

fair_candy_swap(A, B) ->
  SumA = lists:sum(A),
  SumB = lists:sum(B),
  Diff = (SumB - SumA) div 2,
  SetB = sets:from_list(B),
  lists:foldl(
    fun(X, Acc) ->
      if sets:is_element(X - Diff, SetB) then
        [X, X - Diff]
      else
        Acc
      end
    end,
    [],
    A
  ).