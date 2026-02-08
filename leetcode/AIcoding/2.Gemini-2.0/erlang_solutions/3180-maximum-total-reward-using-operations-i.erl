-module(solution).
-export([maximum_total_reward/2]).

maximum_total_reward(Operations, Rewards) ->
  maximum_total_reward(Operations, Rewards, 0).

maximum_total_reward([], _Rewards, Acc) ->
  Acc;
maximum_total_reward(_Operations, [], Acc) ->
  Acc;
maximum_total_reward(Operations, Rewards, Acc) ->
  {MaxReward1, RemainingOperations1, RemainingRewards1} = try_remove_first(Operations, Rewards),
  {MaxReward2, RemainingOperations2, RemainingRewards2} = try_remove_last(Operations, Rewards),

  case MaxReward1 > MaxReward2 of
    true ->
      maximum_total_reward(RemainingOperations1, RemainingRewards1, Acc + MaxReward1);
    false ->
      maximum_total_reward(RemainingOperations2, RemainingRewards2, Acc + MaxReward2)
  end.

try_remove_first([Op | RestOps], [Reward | RestRewards]) ->
  {Reward * Op, RestOps, RestRewards};
try_remove_first([], []) ->
  {0, [], []};
try_remove_first([], _) ->
  {0, [], []};
try_remove_first(_, []) ->
  {0, [], []}.

try_remove_last(Operations, Rewards) ->
  try_remove_last(Operations, Rewards, [], []).

try_remove_last([Op], [Reward], AccOps, AccRewards) ->
  NewOps = lists:reverse(AccOps),
  NewRewards = lists:reverse(AccRewards),
  {Reward * Op, NewOps, NewRewards};
try_remove_last([Op | RestOps], [Reward | RestRewards], AccOps, AccRewards) ->
  try_remove_last(RestOps, RestRewards, [Op | AccOps], [Reward | AccRewards]);
try_remove_last([], [], _, _) ->
  {0, [], []};
try_remove_last([], _, _, _) ->
  {0, [], []};
try_remove_last(_, [], _, _) ->
  {0, [], []}.