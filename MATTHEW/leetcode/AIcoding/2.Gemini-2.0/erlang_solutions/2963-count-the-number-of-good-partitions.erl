-module(good_partitions).
-export([number_of_good_partitions/1]).

number_of_good_partitions(Nums) ->
  number_of_good_partitions(Nums, 0, {}).

number_of_good_partitions([], Acc, _) ->
  case Acc of
    0 -> 1;
    _ -> erlang:integer_to_list(Acc)
  end.

number_of_good_partitions(Nums, Acc, LastSeen) ->
  Len = length(Nums),
  Last = lists:last(Nums),
  LastIndex = find_last_index(Nums, Last, Len),
  case maps:is_key(Last, LastSeen) of
    true ->
      number_of_good_partitions(lists:sublist(Nums, 1, LastIndex-1), Acc, LastSeen);
    false ->
      NewLastSeen = maps:put(Last, LastIndex, LastSeen),
      number_of_good_partitions(lists:sublist(Nums, 1, LastIndex-1), Acc+1, NewLastSeen)
  end.

find_last_index(Nums, Value, Len) ->
  find_last_index(Nums, Value, Len, 0).

find_last_index([], _, _, Acc) ->
  Acc.

find_last_index([H|T], Value, Len, Acc) ->
  if H == Value ->
    find_last_index(T, Value, Len, Acc+1);
  true ->
    find_last_index(T, Value, Len, Acc+1)
  end.

number_of_good_partitions_main(Nums) ->
  P = number_of_good_partitions_helper(Nums),
  power(2, P-1, 1000000007).

number_of_good_partitions_helper(Nums) ->
  LastSeen = lists:foldl(fun(X, Acc) -> maps:put(X, X, Acc) end, #{}, Nums),
  number_of_good_partitions_helper(Nums, LastSeen, 0).

number_of_good_partitions_helper([], _, Acc) ->
  Acc.

number_of_good_partitions_helper(Nums, LastSeen, Acc) ->
  Last = lists:last(Nums),
  LastIndex = find_last_index(Nums, Last, length(Nums)),
  case maps:is_key(Last, LastSeen) of
    true ->
      number_of_good_partitions_helper(lists:sublist(Nums, 1, LastIndex-1), LastSeen, Acc);
    false ->
      number_of_good_partitions_helper(lists:sublist(Nums, 1, LastIndex-1), LastSeen, Acc + 1)
  end.

power(Base, Exp, Mod) ->
  power(Base, Exp, Mod, 1).

power(_, 0, _, Result) ->
  Result;
power(Base, Exp, Mod, Result) when Exp rem 2 == 0 ->
  power((Base * Base) rem Mod, Exp div 2, Mod, Result) ;
power(Base, Exp, Mod, Result) ->
  power(Base, Exp - 1, Mod, (Result * Base) rem Mod).