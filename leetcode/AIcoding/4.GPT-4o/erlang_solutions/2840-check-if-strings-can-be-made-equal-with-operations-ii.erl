-module(solution).
-export([check_if_equal/2]).

check_if_equal(S1, S2) ->
    case length(S1) =:= length(S2) of
        false -> false;
        true -> 
            Sorted1 = lists:sort(string:to_list(S1)),
            Sorted2 = lists:sort(string:to_list(S2)),
            Sorted1 =:= Sorted2
    end.