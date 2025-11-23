-module(solution).
-export([check_if_all_covered/3]).

-spec check_if_all_covered(Ranges :: [[integer()]], Left :: integer(), Right :: integer()) -> boolean().
check_if_all_covered(Ranges, Left, Right) ->
    check_range_elements(Ranges, Left, Right).

check_range_elements(_Ranges, Current, Right) when Current > Right ->
    true;
check_range_elements(Ranges, Current, Right) ->
    case is_covered(Ranges, Current) of
        true ->
            check_range_elements(Ranges, Current + 1, Right);
        false ->
            false
    end.

is_covered([], _Num) ->
    false;
is_covered([[Start, End] | Rest], Num) ->
    if
        Start =< Num andalso Num =< End ->
            true;
        true ->
            is_covered(Rest, Num)
    end.