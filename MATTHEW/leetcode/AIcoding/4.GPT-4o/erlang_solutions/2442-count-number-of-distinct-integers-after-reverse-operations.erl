-module(solution).
-export([distinct_integers_count/1]).

distinct_integers_count(Numbers) ->
    Numbers1 = lists:map(fun(N) -> N end, Numbers),
    Numbers2 = lists:map(fun(N) -> list_to_integer(lists:reverse(integer_to_list(N))) end, Numbers),
    UniqueNumbers = lists:usort(Numbers1 ++ Numbers2),
    length(UniqueNumbers).