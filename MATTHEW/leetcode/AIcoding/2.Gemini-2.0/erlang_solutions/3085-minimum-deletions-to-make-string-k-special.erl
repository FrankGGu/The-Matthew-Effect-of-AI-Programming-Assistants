-module(minimum_deletions_k_special).
-export([solve/2]).

solve(S, K) ->
  Len = length(S),
  {Counts, _} = lists:foldl(
    fun(C, {Acc, Seen}) ->
      case lists:member(C, Seen) of
        true ->
          {lists:keyreplace(C, 1, Acc, {C, element(2, lists:keyfind(C, 1, Acc)) + 1}), Seen};
        false ->
          {[{C, 1} | Acc], [C | Seen]}
      end
    end, {[], []}, S),
  SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A > B end, Counts),
  Deletions = lists:sum([element(2, X) || X <- lists:nthtail(K, SortedCounts)]),
  Deletions.