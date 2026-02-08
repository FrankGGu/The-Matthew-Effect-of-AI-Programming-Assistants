-module(number_of_ways).
-export([number_of_ways/1]).

number_of_ways(S) ->
    Len = length(S),
    number_of_ways_helper(S, Len).

number_of_ways_helper(S, Len) ->
    number_of_ways_helper(S, Len, 0, 0, 0, 0, 0, 0).

number_of_ways_helper(_, 0, Z0, Z01, Z01Z, O1, O10, O10O) ->
    Z01Z + O10O;
number_of_ways_helper([H|T], Len, Z0, Z01, Z01Z, O1, O10, O10O) ->
    case H of
        $0 ->
            number_of_ways_helper(T, Len - 1, Z0 + 1, Z01 + Z0, Z01Z + Z01, O1, O10, O10O);
        $1 ->
            number_of_ways_helper(T, Len - 1, Z0, Z01, Z01Z, O1 + 1, O10 + Z0, O10O + O10)
    end.