-module(minimum_operations_binary_tree_sort).
-export([minimum_operations/1]).

minimum_operations(Root) ->
  minimum_operations(Root, []).

minimum_operations(Root, Acc) ->
  Levels = level_order(Root),
  lists:foldl(fun(Level, Sum) ->
                  Sum + calculate_swaps(Level)
              end, 0, Levels).

level_order(Root) ->
  level_order([Root], []).

level_order([], Acc) ->
  lists:reverse(Acc);
level_order(Nodes, Acc) ->
  NextLevel = [],
  Values = [],
  lists:foreach(fun(Node) ->
                  case Node of
                    null ->
                      ok;
                    {Val, Left, Right} ->
                      Values = [Val | Values],
                      NextLevel = [Left, Right | NextLevel]
                  end
                end, Nodes),
  NextLevelReversed = lists:reverse(NextLevel),
  level_order(NextLevelReversed, [lists:reverse(Values) | Acc]).

calculate_swaps(List) ->
  calculate_swaps(List, 0).

calculate_swaps(List, Acc) ->
  Sorted = lists:keysort(1, lists:zip(List, lists:seq(1, length(List)))),
  calculate_swaps_helper(Sorted, Acc).

calculate_swaps_helper([], Acc) ->
  Acc;
calculate_swaps_helper([{_, Index} | T], Acc) ->
  case Index of
    1 ->
      calculate_swaps_helper(lists:map(fun({Val, I}) -> {Val, I - 1} end, T), Acc);
    _ ->
      calculate_swaps_helper(lists:map(fun({Val, I}) -> if I < Index then {Val, I - 1} else {Val, I} end, T), Acc + 1)
  end.