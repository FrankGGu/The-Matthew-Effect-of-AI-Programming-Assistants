-module(maximize_distance_to_closest_person).
-export([max_dist_to_closest/1]).

max_dist_to_closest(Seats) ->
  max_dist_to_closest(Seats, 0, 0, []).

max_dist_to_closest([], Last, Count, Acc) ->
  case Last of
    0 ->
      lists:max([Count | Acc]);
    _ ->
      lists:max(Acc)
  end;
max_dist_to_closest([0 | Rest], 0, Count, Acc) ->
  max_dist_to_closest(Rest, 0, Count + 1, Acc);
max_dist_to_closest([0 | Rest], 1, Count, Acc) ->
  max_dist_to_closest(Rest, 1, 1, [Count div 2 | Acc]);
max_dist_to_closest([1 | Rest], 0, Count, Acc) ->
  max_dist_to_closest(Rest, 1, 0, [Count | Acc]);
max_dist_to_closest([1 | Rest], 1, Count, Acc) ->
  max_dist_to_closest(Rest, 1, 0, Acc).