-module(number_of_ways_to_split_array).
-export([num_ways_to_split_array/1]).

num_ways_to_split_array(Nums) ->
  num_ways_to_split_array(Nums, 0, lists:sum(Nums), 0).

num_ways_to_split_array([], _, _, Count) ->
  Count;
num_ways_to_split_array([H|T], LeftSum, TotalSum, Count) ->
  NewLeftSum = LeftSum + H,
  RightSum = TotalSum - NewLeftSum,
  NewCount = case NewLeftSum >= RightSum of
    true -> Count + 1;
    false -> Count
  end,
  num_ways_to_split_array(T, NewLeftSum, TotalSum, NewCount).