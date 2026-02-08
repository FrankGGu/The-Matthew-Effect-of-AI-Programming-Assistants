-module(max_level_sum).
-export([max_level_sum/1]).

max_level_sum(Root) ->
  max_level_sum(Root, 1, [], 0, 0).

max_level_sum(null, _Level, LevelSums, MaxLevel, MaxSum) ->
  lists:foldl(fun({Level, Sum}, {MaxLevelAcc, MaxSumAcc}) ->
                  if Sum > MaxSumAcc ->
                    {Level, Sum};
                  true ->
                    {MaxLevelAcc, MaxSumAcc}
                  end
              end, {MaxLevel, MaxSum}, LevelSums);
max_level_sum(Node, Level, LevelSums, MaxLevel, MaxSum) ->
  {Val, Left, Right} = Node,
  NewLevelSums = update_level_sums(Level, Val, LevelSums),
  max_level_sum(Right, Level + 1,
                max_level_sum(Left, Level + 1, NewLevelSums, MaxLevel, MaxSum)).

update_level_sums(Level, Val, LevelSums) ->
  case lists:keyfind(Level, 1, LevelSums) of
    false ->
      [{Level, Val} | LevelSums];
    {Level, Sum} ->
      lists:keyreplace(Level, 1, LevelSums, {Level, Sum + Val})
  end.