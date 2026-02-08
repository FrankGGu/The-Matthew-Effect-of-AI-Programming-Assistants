-module(smallest_chair).
-export([smallest_unoccupied_chair/2]).

smallest_unoccupied_chair(Arrivals, TargetFriend) ->
  smallest_unoccupied_chair(Arrivals, TargetFriend, [], 0).

smallest_unoccupied_chair([], _, Taken, Next) ->
  case lists:member(Next, Taken) of
    true -> smallest_unoccupied_chair([], _, Taken, Next + 1);
    false -> Next
  end;
smallest_unoccupied_chair([H|T], TargetFriend, Taken, Next) ->
  case H =:= TargetFriend of
    true ->
      case lists:member(Next, Taken) of
        true -> smallest_unoccupied_chair([H|T], TargetFriend, Taken, Next + 1);
        false -> Next
      end;
    false ->
      case lists:member(Next, Taken) of
        true -> smallest_unoccupied_chair([H|T], TargetFriend, Taken, Next + 1);
        false -> smallest_unoccupied_chair(T, TargetFriend, [Next|Taken], Next + 1)
      end
  end.

smallest_unoccupied_chair(Arrivals, TargetFriend, Taken, Next) when is_list(Arrivals) ->
  SortedArrivals = lists:keysort(1, lists:zip(Arrivals, lists:seq(1, length(Arrivals)))),
  smallest_unoccupied_chair2(SortedArrivals, TargetFriend, [], 0).

smallest_unoccupied_chair2([], _, Taken, Next) ->
  case lists:member(Next, Taken) of
    true -> smallest_unoccupied_chair2([], _, Taken, Next + 1);
    false -> Next
  end;
smallest_unoccupied_chair2([{Arrival, Index} | T], TargetFriend, Taken, Next) ->
  case Index =:= TargetFriend of
    true ->
      case lists:member(Next, Taken) of
        true -> smallest_unoccupied_chair2([{Arrival, Index} | T], TargetFriend, Taken, Next + 1);
        false -> Next
      end;
    false ->
      case lists:member(Next, Taken) of
        true -> smallest_unoccupied_chair2([{Arrival, Index} | T], TargetFriend, Taken, Next + 1);
        false -> smallest_unoccupied_chair2(T, TargetFriend, [Next|Taken], Next + 1)
      end
  end.