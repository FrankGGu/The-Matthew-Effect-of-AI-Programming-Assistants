-module(find_closest_person).
-export([solve/1]).

solve(Input) ->
    People = maps:get(people, Input),
    Points = maps:get(points, Input),
    Start = maps:get(start, Input),

    find_closest(People, Points, Start).

find_closest(People, Points, Start) ->
    Closest = lists:foldl(
        fun(Person, Acc) ->
            Point = lists:nth(Person, Points),
            Distance = abs(Point - Start),
            case Acc of
                none -> {Person, Distance};
                {BestPerson, BestDistance} ->
                    if
                        Distance < BestDistance -> {Person, Distance};
                        Distance == BestDistance andalso Person < BestPerson -> {Person, Distance};
                        true -> {BestPerson, BestDistance}
                    end
            end
        end,
        none,
        lists:seq(0, length(People) - 1)
    ),
    case Closest of
        none -> -1;
        {Person, _} -> Person
    end.