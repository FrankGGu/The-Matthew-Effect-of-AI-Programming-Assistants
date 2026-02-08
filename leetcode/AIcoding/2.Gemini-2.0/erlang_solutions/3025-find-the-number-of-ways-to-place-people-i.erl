-module(solution).
-export([number_of_ways/1]).

number_of_ways(People) ->
    N = length(People),
    PeopleSorted = lists:sort(People),
    number_of_ways_helper(PeopleSorted, 0, N).

number_of_ways_helper([], Acc, _) ->
    Acc;
number_of_ways_helper([Head | Tail], Acc, N) ->
    ValidPlacements = count_valid_placements(Head, Tail),
    number_of_ways_helper(Tail, Acc + ValidPlacements, N).

count_valid_placements({X1, Y1}, People) ->
    count_valid_placements({X1, Y1}, People, 0).

count_valid_placements(_, [], Acc) ->
    Acc;
count_valid_placements({X1, Y1}, [{X2, Y2} | Rest], Acc) ->
    if
        X1 =< X2 andalso Y1 >= Y2 ->
            count_valid_placements({X1, Y1}, Rest, Acc);
        true ->
            count_valid_placements({X1, Y1}, Rest, Acc + 1)
    end.