-module(two_sum).
-export([two_sum/2]).

two_sum(Nums, Target) ->
  two_sum_helper(Nums, Target, 1, []).

two_sum_helper([H|T], Target, Index, Acc) ->
  case find_sum(H, T, Target, Index) of
    {true, J} ->
      [Index, J + Index];
    false ->
      two_sum_helper(T, Target, Index + 1, Acc)
  end;
two_sum_helper([], _Target, _Index, _Acc) ->
  [].

find_sum(Num, [H|T], Target, Index) ->
  if
    Num + H == Target ->
      {true, Index};
    true ->
      find_sum(Num, T, Target, Index + 1)
  end;
find_sum(_Num, [], _Target, _Index) ->
  false.