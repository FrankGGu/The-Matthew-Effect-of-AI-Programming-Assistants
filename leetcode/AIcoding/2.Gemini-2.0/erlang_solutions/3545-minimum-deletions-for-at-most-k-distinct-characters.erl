-module(min_deletions).
-export([min_deletions/2]).

min_deletions(S, K) ->
  min_deletions(S, K, []).

min_deletions(S, K, Acc) ->
  Len = length(S),
  case Len of
    0 -> 0;
    _ ->
      Counts = lists:foldl(
                 fun(C, Acc1) ->
                   case lists:keyfind(C, 1, Acc1) of
                     false -> [{C, 1} | Acc1];
                     {C, Count} -> lists:keyreplace(C, 1, Acc1, {C, Count + 1})
                   end
                 end, [], S),
      SortedCounts = lists:reverse(lists:keysort(2, Counts)),
      case length(SortedCounts) =< K of
        true -> 0;
        false ->
          NumToDelete = length(SortedCounts) - K,
          SortedCounts1 = lists:sort(fun({_, A}, {_, B}) -> A < B end, Counts),
          lists:foldl(fun({_, Count}, Acc2) -> Acc2 + Count end, 0, lists:sublist(SortedCounts1, 1, NumToDelete))
      end
  end.