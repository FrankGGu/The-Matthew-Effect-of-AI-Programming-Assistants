-module(k_increasing).
-export([min_operations/1]).

min_operations(Arr) ->
  K = 1;
  N = length(Arr);
  case N =< 0 of
    true -> 0;
    false ->
      K = 1,
      lists:foldl(
        fun(I, Acc) ->
          Acc + min_ops_for_subsequence(get_subsequence(Arr, N, I, K))
        end,
        0,
        lists:seq(0, K - 1)
      )
  end.

get_subsequence(Arr, N, Start, K) ->
  lists:filter(
    fun(I) -> I < N end,
    lists:map(fun(I) -> lists:nth(I + 1, Arr) end, lists:seq(Start, N - 1, K))
  ).

min_ops_for_subsequence(Subsequence) ->
  N = length(Subsequence);
  case N =< 0 of
    true -> 0;
    false ->
      LISLength = longest_increasing_subsequence_length(Subsequence),
      N - LISLength
  end.

longest_increasing_subsequence_length(Subsequence) ->
  TailTable = [],
  lists:foldl(
    fun(Num, Acc) ->
      update_tail_table(Acc, Num)
    end,
    TailTable,
    Subsequence
  ),
  length(TailTable).

update_tail_table([], Num) ->
  [Num];
update_tail_table(TailTable, Num) ->
  case find_index(TailTable, Num) of
    -1 ->
      TailTable ++ [Num];
    Index ->
      lists:nth(Index + 1, TailTable) = Num,
      TailTable
  end.

find_index(TailTable, Num) ->
  find_index_helper(TailTable, Num, 0).

find_index_helper([], _, _) ->
  -1;
find_index_helper([H | T], Num, Index) ->
  case H >= Num of
    true ->
      Index;
    false ->
      find_index_helper(T, Num, Index + 1)
  end.