-module(eliminate_maximum_number_of_monsters).
-export([eliminate_maximum_number_of_monsters/2]).

eliminate_maximum_number_of_monsters(Dist, Speed) ->
  Times = [math:ceil(D / S) || D <- Dist, S <- Speed],
  eliminate_maximum_number_of_monsters_helper(lists:sort(Times), 0, 0).

eliminate_maximum_number_of_monsters_helper([], _, Count) ->
  Count;
eliminate_maximum_number_of_monsters_helper([Time | Rest], CurrentTime, Count) ->
  if Time > CurrentTime then
    eliminate_maximum_number_of_monsters_helper(Rest, CurrentTime + 1, Count + 1)
  else
    Count
  end.