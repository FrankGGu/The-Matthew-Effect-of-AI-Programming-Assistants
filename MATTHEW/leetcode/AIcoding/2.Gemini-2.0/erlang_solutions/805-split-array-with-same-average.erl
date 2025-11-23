-module(split_array_with_same_average).
-export([split_array/1]).

split_array(Nums) ->
  N = length(Nums),
  if N =< 1,
    false
  else
    Sum = lists:sum(Nums),
    case check(Nums, N, 0, 0, Sum) of
      true -> true;
      false -> false
    end
  end.

check(_Nums, _N, Len, SumA, Sum) when Len > 0 ->
  SumA * _N =:= Sum * Len;
check(_Nums, _N, _N, _SumA, _Sum) ->
  false;
check(Nums, N, Len, SumA, Sum) ->
  H = lists:nth(Len + 1, Nums),
  check(Nums, N, Len + 1, SumA + H, Sum) orelse check(Nums, N, Len + 1, SumA, Sum).