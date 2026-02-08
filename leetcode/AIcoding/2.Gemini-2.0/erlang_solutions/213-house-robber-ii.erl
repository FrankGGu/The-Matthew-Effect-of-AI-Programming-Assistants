-module(house_robber_ii).
-export([rob/1]).

rob(Nums) ->
  Len = length(Nums),
  if Len == 0 ->
    0;
  Len == 1 ->
    hd(Nums);
  true ->
    Max1 = rob_helper(lists:sublist(Nums, 1, Len - 1)),
    Max2 = rob_helper(lists:sublist(Nums, 2, Len - 1)),
    max(Max1, Max2)
  end.

rob_helper(Nums) ->
  Len = length(Nums),
  case Len of
    0 -> 0;
    1 -> hd(Nums);
    2 -> max(hd(Nums), lists:nth(2, Nums));
    _ ->
      Dp = lists:foldl(
        fun(Num, Acc) ->
          case Acc of
            [] -> [Num];
            [Prev] -> [Num, max(Num, Prev)];
            [Prev1, Prev2 | _] -> [max(Prev1, Prev2 + Num), Prev1 | lists:sublist(Acc, 1, 2)]
          end
        end, [], Nums),
      case Dp of
        [Result, _ | _] -> Result;
        [Result] -> Result
      end
  end.

max(A, B) ->
  if A > B -> A;
  true -> B
  end.