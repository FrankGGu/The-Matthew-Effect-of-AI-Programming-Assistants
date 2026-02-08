-module(partition_array).
-export([pivotArray/1]).

pivotArray(Nums) ->
  pivotArray(Nums, lists:nth(1, Nums), [], [], []).

pivotArray([], _, Less, Equal, Greater) ->
  lists:reverse(Less) ++ Equal ++ lists:reverse(Greater);
pivotArray([H|T], Pivot, Less, Equal, Greater) ->
  case H < Pivot of
    true ->
      pivotArray(T, Pivot, [H|Less], Equal, Greater);
    false ->
      case H == Pivot of
        true ->
          pivotArray(T, Pivot, Less, [H|Equal], Greater);
        false ->
          pivotArray(T, Pivot, Less, Equal, [H|Greater])
      end
  end.