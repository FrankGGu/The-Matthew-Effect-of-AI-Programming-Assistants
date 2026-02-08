-module(minimum_subsequence).
-export([min_subsequence/1]).

min_subsequence(Nums) ->
  {Sum, SortedNums} = lists:foldl(
    fun(N, {AccSum, AccList}) ->
      {AccSum + N, lists:insert(
        fun(A, B) -> A >= B end,
        AccList,
        N
      )}
    end,
    {0, []},
    Nums
  ),
  min_subsequence_helper(SortedNums, Sum, 0, []).

min_subsequence_helper([], _, _, Acc) ->
  lists:reverse(Acc);
min_subsequence_helper([H | T], TotalSum, CurrentSum, Acc) ->
  if
    CurrentSum + H > TotalSum - CurrentSum - H ->
      lists:reverse([H | Acc]);
    true ->
      min_subsequence_helper(T, TotalSum, CurrentSum + H, [H | Acc])
  end.