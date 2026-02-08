-module(solution).
-export([count_squares/1]).

count_squares(Mat) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    DP = array:new({size, Rows}, {default, 0}),
    Count = 0,
    count_squares(Mat, DP, 0, 0, Count).

count_squares(Mat, DP, R, C, Count) ->
    case R of
        Rows when R >= length(Mat) -> Count;
        _ ->
            case C of
                Cols when C >= length(hd(Mat)) -> count_squares(Mat, DP, R+1, 0, Count);
                _ ->
                    Val = lists:nth(C+1, lists:nth(R, Mat)),
                    if
                        Val == 1 ->
                            NewCount = Count + 1,
                            if
                                R == 0; C == 0 ->
                                    NewDP = array:set({R, C}, 1, DP),
                                    count_squares(Mat, NewDP, R, C+1, NewCount);
                                true ->
                                    Prev = array:get({R-1, C-1}, DP),
                                    Up = array:get({R-1, C}, DP),
                                    Left = array:get({R, C-1}, DP),
                                    Min = min(Prev, min(Up, Left)),
                                    NewVal = Min + 1,
                                    NewDP = array:set({R, C}, NewVal, DP),
                                    count_squares(Mat, NewDP, R, C+1, NewCount + (NewVal - 1))
                            end;
                        true ->
                            NewDP = array:set({R, C}, 0, DP),
                            count_squares(Mat, NewDP, R, C+1, Count)
                    end
            end
    end.