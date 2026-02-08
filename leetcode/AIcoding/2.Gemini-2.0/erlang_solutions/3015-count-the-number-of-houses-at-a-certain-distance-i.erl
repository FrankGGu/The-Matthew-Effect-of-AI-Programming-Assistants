-module(houses).
-export([count_of_pairs/3]).

count_of_pairs(N, X, Y) ->
  count_of_pairs(N, X, Y, []).

count_of_pairs(N, X, Y, Acc) ->
  count_of_pairs(N, X, Y, 1, lists:duplicate(N, 0)).

count_of_pairs(N, X, Y, Start, Acc) when Start > N ->
  Acc;
count_of_pairs(N, X, Y, Start, Acc) ->
  NewAcc = count_distances(N, X, Y, Start, Acc),
  count_of_pairs(N, X, Y, Start + 1, NewAcc).

count_distances(N, X, Y, Start, Acc) ->
  count_distances(N, X, Y, Start, 1, Acc).

count_distances(N, X, Y, Start, End, Acc) when End > N ->
  Acc;
count_distances(N, X, Y, Start, End, Acc) ->
  Distance = get_distance(N, X, Y, Start, End),
  NewAcc = update_acc(Acc, Distance),
  count_distances(N, X, Y, Start, End + 1, NewAcc).

get_distance(N, X, Y, Start, End) ->
  case Start == End of
    true -> 0;
    false ->
      DirectDistance = abs(Start - End),
      IndirectDistance = abs(Start - X) + 1 + abs(Y - End),
      min(DirectDistance, IndirectDistance)
  end.

update_acc(Acc, Distance) ->
  lists:nth(Distance + 1, Acc) + 1 ->
    lists:nth(Distance + 1, Acc) + 1;
  lists:replace(Distance + 1, lists:nth(Distance + 1, Acc) + 1, Acc).