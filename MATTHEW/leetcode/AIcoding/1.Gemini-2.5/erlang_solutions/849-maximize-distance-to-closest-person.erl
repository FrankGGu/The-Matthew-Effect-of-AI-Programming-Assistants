-module(solution).
-export([max_distance_to_closest_person/1]).

-spec max_distance_to_closest_person(Seats :: [0 | 1]) -> integer().
max_distance_to_closest_person(Seats) ->
    IndicesOfOnes = find_indices_of_ones(Seats, 0, []),
    Len = length(Seats),

    LeftMax = hd(IndicesOfOnes),

    LastOneIdx = lists:last(IndicesOfOnes),
    RightMax = (Len - 1) - LastOneIdx,

    BetweenMax = find_max_between_ones(IndicesOfOnes),

    lists:max([LeftMax, RightMax, BetweenMax]).

find_indices_of_ones([], _Idx, Acc) ->
    lists:reverse(Acc);
find_indices_of_ones([1 | T], Idx, Acc) ->
    find_indices_of_ones(T, Idx + 1, [Idx | Acc]);
find_indices_of_ones([0 | T], Idx, Acc) ->
    find_indices_of_ones(T, Idx + 1, Acc).

find_max_between_ones([_]) -> 0;
find_max_between_ones([H1, H2 | T]) ->
    MaxDist = (H2 - H1) div 2,
    find_max_between_ones([H2 | T], MaxDist).

find_max_between_ones([_], CurrentMax) -> CurrentMax;
find_max_between_ones([H1, H2 | T], CurrentMax) ->
    NewDist = (H2 - H1) div 2,
    find_max_between_ones([H2 | T], max(CurrentMax, NewDist)).