-module(p1682).
-export([number_of_paths/2]).

number_of_paths(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    DP = array:new({0, Rows-1}, {0, array:new({0, Cols-1}, 0)}),
    number_of_paths(Matrix, K, 0, 0, 0, DP).

number_of_paths(_, _, Row, Col, Sum, _) when Row >= length(Matrix) orelse Col >= length(hd(Matrix)) ->
    0;

number_of_paths(Matrix, K, Row, Col, Sum, DP) ->
    Current = lists:nth(Row+1, Matrix),
    Val = lists:nth(Col+1, Current),
    NewSum = (Sum + Val) rem K,
    if
        Row == 0 andalso Col == 0 ->
            case NewSum of
                0 -> 1;
                _ -> 0
            end;
        true ->
            Count = 0,
            if
                Row > 0 ->
                    Count1 = get_or_zero(DP, Row-1, Col),
                    Count = Count + Count1;
                true ->
                    Count
            end,
            if
                Col > 0 ->
                    Count2 = get_or_zero(DP, Row, Col-1),
                    Count = Count + Count2;
                true ->
                    Count
            end,
            set_or_update(DP, Row, Col, Count),
            Count
    end.

get_or_zero(DP, Row, Col) ->
    array:get(Row, DP),
    array:get(Col, array:get(Row, DP)).

set_or_update(DP, Row, Col, Value) ->
    Prev = get_or_zero(DP, Row, Col),
    array:set(Row, array:set(Col, Value + Prev, array:get(Row, DP)), DP).