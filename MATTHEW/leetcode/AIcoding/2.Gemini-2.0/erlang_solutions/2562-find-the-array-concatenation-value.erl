-module(find_array_concatenation_value).
-export([find_final_value/1]).

find_final_value(Nums) ->
  find_final_value(Nums, 0).

find_final_value([], Acc) ->
  Acc;
find_final_value([N], Acc) ->
  Acc + N;
find_final_value(Nums, Acc) ->
  {First, Rest} = lists:split(1, Nums),
  Last = lists:last(Rest),
  RestWithoutLast = lists:sublist(Rest, 1, length(Rest) - 1),
  NumStr = integer_to_list(hd(First)) ++ integer_to_list(Last),
  NewAcc = Acc + list_to_integer(NumStr),
  find_final_value(RestWithoutLast, NewAcc).