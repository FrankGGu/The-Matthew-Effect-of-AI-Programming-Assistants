-module(average_of_levels).
-export([average_of_levels/1]).

average_of_levels(Root) ->
  levels_sum_count(Root, [], 0, []).

levels_sum_count(null, Acc, Level, Result) ->
  lists:reverse([lists:sum(Sums) / Counts || {Sums, Counts} <- lists:sort(fun({_, L1}, {_, L2}) -> L1 < L2 end, Result)]);
levels_sum_count(Node, Acc, Level, Result) ->
  {Val, Left, Right} = Node,
  NewResult =
    case lists:keyfind(Level, 2, Result) of
      false ->
        [{[Val], Level} | Result];
      {Sums, Level} ->
        lists:keyreplace(Level, 2, Result, {[Val | Sums], Level})
    end,
  levels_sum_count(Left, Acc, Level + 1, NewResult1 = levels_sum_count(Right, Acc, Level + 1, NewResult)).