-module(sorting_three_groups).
-export([minimum_moves/1]).

minimum_moves(Nums) ->
  N = length(Nums),
  {One, Two, Three} = lists:foldl(
    fun(Num, {O, T, Th}) ->
      case Num of
        1 -> {O+1, T, Th};
        2 -> {O, T+1, Th};
        3 -> {O, T, Th+1}
      end
    end,
    {0, 0, 0},
    Nums
  ),

  memo(Nums, 0, One, Two, Three, #{}, N).

memo(_Nums, _Idx, 0, 0, 0, _Memo, _N) ->
  0;
memo(Nums, Idx, One, Two, Three, Memo, N) ->
  case maps:get({Idx, One, Two, Three}, Memo, undefined) of
    Value when is_integer(Value) ->
      Value;
    _ ->
      Key = {Idx, One, Two, Three},
      Result = calculate_moves(Nums, Idx, One, Two, Three, Memo, N),
      NewMemo = maps:put(Key, Result, Memo),
      Result
  end.

calculate_moves(Nums, Idx, One, Two, Three, Memo, N) ->
  if
    Idx >= N ->
      100000000;
    true ->
      Val = lists:nth(Idx+1, Nums),
      Res1 =
        if
          One > 0 ->
            Cost = case Val of 1 -> 0; _ -> 1 end,
            Cost + memo(Nums, Idx+1, One-1, Two, Three, Memo, N);
          true ->
            100000000
        end,
      Res2 =
        if
          Two > 0 ->
            Cost = case Val of 2 -> 0; _ -> 1 end,
            Cost + memo(Nums, Idx+1, One, Two-1, Three, Memo, N);
          true ->
            100000000
        end,
      Res3 =
        if
          Three > 0 ->
            Cost = case Val of 3 -> 0; _ -> 1 end,
            Cost + memo(Nums, Idx+1, One, Two, Three-1, Memo, N);
          true ->
            100000000
        end,

      min(Res1, min(Res2, Res3))
  end.