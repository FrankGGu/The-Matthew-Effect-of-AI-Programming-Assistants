-module(solution).
-export([getSum/2]).

getSum(A, B) ->
  getSum_aux(A, B).

getSum_aux(A, 0) -> A;
getSum_aux(A, B) ->
  Sum = A bxor B,
  Carry = (A band B) bsl 1,
  getSum_aux(Sum, Carry).