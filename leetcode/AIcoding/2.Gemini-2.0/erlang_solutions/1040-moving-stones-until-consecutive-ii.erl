-module(moving_stones_ii).
-export([num_moves_stones_ii/1]).

num_moves_stones_ii(Stones) ->
  SortedStones = lists:sort(Stones),
  N = length(SortedStones),
  MaxMoves = max_moves(SortedStones, N),
  MinMoves = min_moves(SortedStones, N),
  {MinMoves, MaxMoves}.

max_moves(Stones, N) ->
  max(Stones[N] - Stones[2] - N + 2, Stones[N - 1] - Stones[1] - N + 2).

min_moves(Stones, N) ->
  MinMoves = lists:foldl(
    fun(I, Acc) ->
      J = find_j(Stones, I, N);
      Len = J - I + 1;
      if Len == N then
        if Stones[J] - Stones[I] == N - 1 then
          Acc
        else
          min(Acc, 2)
        end
      else
        min(Acc, N - Len)
      end
    end,
    N,
    lists:seq(1, N)
  ),
  MinMoves.

find_j(Stones, I, N) ->
  find_j_helper(Stones, I, N, I).

find_j_helper(Stones, Stones, I, N, J) ->
  if J > N then
    J - 1
  else if Stones[J] - Stones[I] < N then
    find_j_helper(Stones, I, N, J + 1)
  else
    J - 1
  end;
find_j_helper(Stones, I, N, J) ->
  if J > N then
    J - 1
  else if Stones[J] - Stones[I] < N then
    find_j_helper(Stones, Stones, I, N, J + 1)
  else
    J - 1
  end.