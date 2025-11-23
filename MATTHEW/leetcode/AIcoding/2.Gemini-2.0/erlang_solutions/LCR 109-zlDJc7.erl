-module(open_lock).
-export([open_lock/2]).

open_lock(Deadends, Target) ->
  DeadendsSet = sets:from_list(Deadends),
  if sets:is_element(Target, DeadendsSet) ->
    -1;
  true ->
    Queue = [{<<"0000">>, 0}],
    Visited = sets:from_list([<<"0000">>]),
    bfs(Queue, Target, DeadendsSet, Visited)
  end.

bfs([], _Target, _DeadendsSet, _Visited) ->
  -1;
bfs([{Lock, Steps} | Rest], Target, DeadendsSet, Visited) ->
  if Lock == Target ->
    Steps;
  true ->
    NextLocks = get_next_locks(Lock, DeadendsSet, Visited),
    NewQueue = Rest ++ NextLocks,
    NewVisited = lists:foldl(fun(L, Acc) -> sets:add_element(L, Acc) end, Visited, [X || {X, _} <- NextLocks]),
    bfs(NewQueue, Target, DeadendsSet, NewVisited)
  end.

get_next_locks(Lock, DeadendsSet, Visited) ->
  [
    {NewLock, Steps + 1} || NewLock <- get_neighbors(Lock),
    not sets:is_element(NewLock, DeadendsSet),
    not sets:is_element(NewLock, Visited)
  ].

get_neighbors(Lock) ->
  [
    update_digit(Lock, I, (digit(Lock, I) + 1) rem 10) || I <- lists:seq(1, 4)
  ] ++
  [
    update_digit(Lock, I, (digit(Lock, I) + 9) rem 10) || I <- lists:seq(1, 4)
  ].

digit(Lock, Index) ->
  list_to_integer([binary_to_list(Lock)]) div integer_power(10, 4 - Index) rem 10.

update_digit(Lock, Index, NewDigit) ->
  Digits = [list_to_integer([binary_to_list(Lock)]) div integer_power(10, 4 - I) rem 10 || I <- lists:seq(1,4)],
  NewDigits = lists:map(fun(I, D) -> if I == Index then NewDigit else D end, lists:seq(1,4), Digits),
  list_to_binary(integer_to_list(lists:foldl(fun(D, Acc) -> Acc * 10 + D end, 0, NewDigits), 10, 4)).

integer_power(Base, Exponent) ->
  integer_power(Base, Exponent, 1).

integer_power(_Base, 0, Acc) ->
  Acc;
integer_power(Base, Exponent, Acc) ->
  integer_power(Base, Exponent - 1, Acc * Base).