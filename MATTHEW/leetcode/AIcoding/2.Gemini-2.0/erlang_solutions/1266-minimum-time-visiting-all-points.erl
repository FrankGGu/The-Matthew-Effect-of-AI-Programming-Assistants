-module(minimum_time_visiting_all_points).
-export([min_time_to_visit_all_points/1]).

min_time_to_visit_all_points(Points) ->
    min_time_to_visit_all_points(Points, 0).

min_time_to_visit_all_points([_], Acc) ->
    Acc;
min_time_to_visit_all_points([P1, P2 | Rest], Acc) ->
    Acc1 = Acc + max(abs(element(1, P1) - element(1, P2)), abs(element(2, P1) - element(2, P2))),
    min_time_to_visit_all_points([P2 | Rest], Acc1).