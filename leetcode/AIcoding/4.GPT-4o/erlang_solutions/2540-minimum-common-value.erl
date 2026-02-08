-module(solution).
-export([get_minimum_common_value/2]).

get_minimum_common_value(A, B) ->
    A1 = lists:sort(A),
    B1 = lists:sort(B),
    find_common(A1, B1).

find_common([], _) -> -1;
find_common(_, []) -> -1;
find_common([H|T], B) ->
    case lists:member(H, B) of
        true -> H;
        false -> find_common(T, B)
    end.