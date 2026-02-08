-module(minimum_operations).
-export([reinitialize_permutation/1]).

reinitialize_permutation(N) ->
  reinitialize_permutation(N, 0, 1).

reinitialize_permutation(N, Count, Index) ->
  if Index == 1 and Count > 0 ->
    Count;
  true ->
    NewIndex = (Index * 2) rem (N - 1),
    if NewIndex == 0 ->
      reinitialize_permutation(N, Count + 1, N - 1);
    true ->
      reinitialize_permutation(N, Count + 1, NewIndex)
    end
  end.