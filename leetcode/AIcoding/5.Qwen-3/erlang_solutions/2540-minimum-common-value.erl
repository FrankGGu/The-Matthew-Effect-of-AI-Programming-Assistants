-module(minimum_common_value).
-export([min_common_value/2]).

min_common_value(A, B) ->
    SetB = sets:from_list(B),
    find_common(A, SetB).

find_common([], _) ->
    -1;
find_common([H | T], SetB) ->
    case sets:is_element(H, SetB) of
        true -> H;
        false -> find_common(T, SetB)
    end.