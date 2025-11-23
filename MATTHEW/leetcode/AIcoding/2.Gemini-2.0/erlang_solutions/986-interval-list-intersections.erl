-module(interval_list_intersections).
-export([interval_intersection/2]).

interval_intersection(A, B) ->
  interval_intersection(A, B, []).

interval_intersection([], _, Acc) ->
  lists:reverse(Acc);
interval_intersection(_, [], Acc) ->
  lists:reverse(Acc);
interval_intersection([A1|RestA], [B1|RestB], Acc) ->
  [StartA, EndA] = A1,
  [StartB, EndB] = B1,
  Low = max(StartA, StartB),
  High = min(EndA, EndB),
  case Low =< High of
    true ->
      case EndA < EndB of
        true ->
          interval_intersection(RestA, [B1|RestB], [[Low, High]|Acc]);
        false ->
          interval_intersection([A1|RestA], RestB, [[Low, High]|Acc])
      end;
    false ->
      case EndA < EndB of
        true ->
          interval_intersection(RestA, [B1|RestB], Acc);
        false ->
          interval_intersection([A1|RestA], RestB, Acc)
      end
  end.