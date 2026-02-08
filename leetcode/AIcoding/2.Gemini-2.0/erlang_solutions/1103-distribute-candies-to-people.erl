-module(distribute_candies).
-export([distribute_candies/2]).

distribute_candies(Candies, Num_people) ->
  distribute_candies_helper(Candies, Num_people, 1, []).

distribute_candies_helper(0, _, _, Acc) ->
  lists:reverse(Acc);
distribute_candies_helper(Candies, Num_people, Round, Acc) ->
  Index = (Round - 1) rem Num_people,
  if Round > Candies ->
    New_candies = 0,
    New_acc = lists:nth(Index+1, lists:reverse(Acc)) + Candies,
    New_list = lists:reverse(Acc),
    New_list2 = lists:nthtail(Num_people - Index -1, New_list),
    New_list3 = lists:sublist(New_list, Num_people - Index -1),
    New_acc_list = lists:reverse([New_acc | New_list2]) ++ New_list3,
    lists:reverse(New_acc_list);
  true ->
    New_candies = Candies - Round,
    New_acc = lists:nth(Index+1, lists:reverse(Acc)) + Round,
    New_list = lists:reverse(Acc),
    New_list2 = lists:nthtail(Num_people - Index -1, New_list),
    New_list3 = lists:sublist(New_list, Num_people - Index -1),
    New_acc_list = lists:reverse([New_acc | New_list2]) ++ New_list3,
    distribute_candies_helper(New_candies, Num_people, Round + 1, lists:reverse(New_acc_list))
  end.

distribute_candies(Candies, Num_people) ->
    Result = lists:seq(1, Num_people),
    distribute_candies_helper(Candies, Result, 1, []).

distribute_candies_helper(0, _, _, Acc) ->
    lists:reverse(Acc);
distribute_candies_helper(Candies, Result, Round, Acc) ->
  Index = (Round - 1) rem length(Result),
  Amount = min(Round, Candies),
  New_candies = Candies - Amount,
  Updated_result = lists:update_at(Index + 1, lists:nth(Index + 1,Result) + Amount, Result),
  distribute_candies_helper(New_candies, Updated_result, Round + 1, Updated_result).