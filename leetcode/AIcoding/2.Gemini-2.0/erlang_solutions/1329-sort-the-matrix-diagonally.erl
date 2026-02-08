-module(diagonal_sort).
-export([diagonal_sort/1]).

diagonal_sort(Mat) ->
  N = length(Mat),
  M = length(lists:nth(1, Mat)),

  Diagonals = lists:foldl(
    fun(K, Acc) ->
      Diagonal = [lists:nth(I+1, lists:nth(I+K+1, Mat)) || I <- lists:seq(0, min(N-1-K, M-1))],
      [{K, lists:sort(Diagonal)} | Acc]
    end,
    [],
    lists:seq(0, N-1)
  ) ++ lists:foldl(
    fun(K, Acc) ->
      Diagonal = [lists:nth(I+K+1, lists:nth(I+1, Mat)) || I <- lists:seq(0, min(N-1, M-1-K))],
      [{ -K, lists:sort(Diagonal)} | Acc]
    end,
    [],
    lists:seq(1, M-1)
  ),

  lists:foldl(
    fun(I, Acc) ->
      lists:foldl(
        fun(J, RowAcc) ->
          K = J - I,
          {_, SortedDiagonal} = lists:keyfind(K, 1, Diagonals),
          Index = case K >= 0 of
            true -> J;
            false -> I
          end,
          [lists:nth(Index+1, SortedDiagonal) | RowAcc]
        end,
        [],
        lists:seq(0, M-1)
      ) ++ [$\n] ++ Acc
    end,
    [],
    lists:seq(0, N-1)
  ) |> lists:reverse() |> binary:list_to_binary() |> binary:split(<<$\n>>) |> lists:drop(1) |> lists:map(fun(X) -> string:tokens(binary_to_list(X), " ") end)
  .