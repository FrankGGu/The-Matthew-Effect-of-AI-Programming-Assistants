-module(minimum_operations).
-export([minOperations/2]).

minOperations(Nums, K) ->
  N = length(Nums),
  lists:min([
    minOperationsHelper(lists:sort(Nums), K, (N + 1) div 2),
    minOperationsHelper(lists:sort(Nums), K, (N + 2) div 2)
  ]).

minOperationsHelper(SortedNums, K, MedianIndex) ->
  Median = lists:nth(MedianIndex, SortedNums),
  TotalOperations = 0,
  for(1, length(SortedNums), 1,
    fun(I) ->
      Num = lists:nth(I, SortedNums),
      case Num of
        N when N < K ->
          TotalOperations1 = abs(K - N),
          TotalOperations ! TotalOperations + TotalOperations1;
        N when N > K ->
          TotalOperations1 = abs(K - N),
          TotalOperations ! TotalOperations + TotalOperations1;
        _ ->
          ok
      end
    end),
  case Median of
    M when M < K ->
      TotalOperations1 = abs(K - M),
      TotalOperations ! TotalOperations + TotalOperations1;
    M when M > K ->
      TotalOperations1 = abs(K - M),
      TotalOperations ! TotalOperations + TotalOperations1;
    _ ->
      ok
  end,
  TotalOperations.