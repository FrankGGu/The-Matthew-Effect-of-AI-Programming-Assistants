-module(solution).
-export([max_total_reward/1]).

max_total_reward(Rewards) ->
    lists:max([lists:sum(Subset) || Subset <- subsets(Rewards), valid_subset(Subset)]).

subsets([]) -> [[]];
subsets([H|T]) ->
    Subsets = subsets(T),
    Subsets ++ [[H|Subset] || Subset <- Subsets].

valid_subset([]) -> true;
valid_subset([H|T]) -> valid_subset(T, H).

valid_subset([], _) -> true;
valid_subset([H|T], Sum) ->
    H < Sum andalso valid_subset(T, Sum + H).