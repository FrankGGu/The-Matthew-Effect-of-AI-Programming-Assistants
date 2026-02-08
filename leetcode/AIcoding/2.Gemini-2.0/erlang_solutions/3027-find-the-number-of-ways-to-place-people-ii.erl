-module(find_the_number_of_ways_to_place_people_ii).
-export([number_of_ways/1]).

number_of_ways(People) ->
    SortedPeople = lists:keysort(2, People),
    number_of_ways_helper(SortedPeople, []).

number_of_ways_helper([], _Placed) ->
    1;
number_of_ways_helper([Person | Rest], Placed) ->
    case can_place(Person, Placed) of
        true ->
            number_of_ways_helper(Rest, [Person | Placed]) + number_of_ways_helper(Rest, Placed);
        false ->
            number_of_ways_helper(Rest, Placed)
    end.

can_place([X, Y], Placed) ->
    lists:all(fun([Px, Py]) ->
                      (Px * Y) + (Py) >= (X * Py) + (Y)
              end, Placed).