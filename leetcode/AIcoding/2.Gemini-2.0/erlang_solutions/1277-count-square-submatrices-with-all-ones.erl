-module(count_squares).
-export([count_squares/1]).

count_squares(Matrix) ->
    R = length(Matrix),
    C = length(hd(Matrix)),
    DP = lists:map(fun(_) -> lists:duplicate(C, 0) end, lists:seq(1, R)),
    count_squares_helper(Matrix, R, C, DP, 0, 0, 0).

count_squares_helper(_Matrix, _R, _C, _DP, R, C, Count) when R >= _R, C >= _C ->
    Count;
count_squares_helper(Matrix, _R, _C, DP, R, C, Count) when C >= _C ->
    count_squares_helper(Matrix, _R, _C, DP, R + 1, 0, Count);
count_squares_helper(Matrix, R_Max, C_Max, DP, R, C, Count) ->
    Val = element(C + 1, lists:nth(R + 1, Matrix)),
    case Val of
        1 ->
            Left = get_dp(DP, R, C - 1),
            Up = get_dp(DP, R - 1, C),
            UpLeft = get_dp(DP, R - 1, C - 1),
            Size = min([Left, Up, UpLeft]) + 1,
            NewDP = set_dp(DP, R, C, Size),
            count_squares_helper(Matrix, R_Max, C_Max, NewDP, R, C + 1, Count + Size);
        0 ->
            NewDP = set_dp(DP, R, C, 0),
            count_squares_helper(Matrix, R_Max, C_Max, NewDP, R, C + 1, Count)
    end.

get_dp(DP, R, C) ->
    try
        lists:nth(R + 1, lists:nth(C + 1, DP))
    catch
        _:_ ->
            0
    end.

set_dp(DP, R, C, Val) ->
    lists:nth(R + 1, lists:map(fun(Row, I) ->
                                        case I of
                                            R + 1 ->
                                                lists:nth(C + 1, lists:map(fun(Col, J) ->
                                                                                    case J of
                                                                                        C + 1 ->
                                                                                            Val;
                                                                                        _ ->
                                                                                            Col
                                                                                    end
                                                                            end, Row, lists:seq(1, length(Row))));
                                            _ ->
                                                Row
                                        end
                                end, DP, lists:seq(1, length(DP)))).