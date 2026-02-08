-module(max_trailing_zeros_in_a_cornered_path).
-export([maximum_trailing_zeros/1]).

maximum_trailing_zeros(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Max = 0,
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Col, Acc2) ->
            Value = lists:nth(Row+1, Grid) -- [Col],
            Count = count_trailing_zeros(Value),
            if
                Row == 0 orelse Col == 0 orelse Row == Rows-1 orelse Col == Cols-1 ->
                    Acc2;
                true ->
                    Left = get_trailing_zeros(Grid, Row, Col, left),
                    Right = get_trailing_zeros(Grid, Row, Col, right),
                    Up = get_trailing_zeros(Grid, Row, Col, up),
                    Down = get_trailing_zeros(Grid, Row, Col, down),
                    MaxCurrent = max(Left + Up - count_trailing_zeros(lists:nth(Row+1, Grid) -- [Col]), 
                                     max(Left + Down - count_trailing_zeros(lists:nth(Row+1, Grid) -- [Col]), 
                                          max(Right + Up - count_trailing_zeros(lists:nth(Row+1, Grid) -- [Col]), 
                                              Right + Down - count_trailing_zeros(lists:nth(Row+1, Grid) -- [Col])))),
                    max(Acc2, MaxCurrent)
            end
        end, Acc, lists:seq(0, Cols-1))
    end, Max, lists:seq(0, Rows-1)).

count_trailing_zeros(N) when N == 0 -> 1;
count_trailing_zeros(N) ->
    count_trailing_zeros(N, 0).

count_trailing_zeros(0, Count) -> Count;
count_trailing_zeros(N, Count) ->
    case N rem 10 of
        0 -> count_trailing_zeros(N div 10, Count + 1);
        _ -> Count
    end.

get_trailing_zeros(Grid, Row, Col, Direction) ->
    case Direction of
        left ->
            lists:foldl(fun(C, Acc) ->
                Val = lists:nth(Row+1, Grid) -- [C],
                Acc + count_trailing_zeros(Val)
            end, 0, lists:seq(0, Col-1));
        right ->
            lists:foldl(fun(C, Acc) ->
                Val = lists:nth(Row+1, Grid) -- [C],
                Acc + count_trailing_zeros(Val)
            end, 0, lists:seq(Col+1, length(hd(Grid))-1));
        up ->
            lists:foldl(fun(R, Acc) ->
                Val = lists:nth(R+1, Grid) -- [Col],
                Acc + count_trailing_zeros(Val)
            end, 0, lists:seq(0, Row-1));
        down ->
            lists:foldl(fun(R, Acc) ->
                Val = lists:nth(R+1, Grid) -- [Col],
                Acc + count_trailing_zeros(Val)
            end, 0, lists:seq(Row+1, length(Grid)-1))
    end.