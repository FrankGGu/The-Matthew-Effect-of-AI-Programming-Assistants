-module(solution).
-export([minimize_the_difference/2]).

minimize_the_difference(Mat, Target) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    PossibleSums = sets:from_list([0]),
    PossibleSums1 = process_rows(Mat, Rows, Cols, PossibleSums),
    Sums = sets:to_list(PossibleSums1),
    find_min_diff(Sums, Target, infinity).

process_rows(Mat, 0, _, PossibleSums) -> PossibleSums;
process_rows(Mat, Row, Cols, PossibleSums) ->
    CurrentRow = lists:nth(Row, Mat),
    NewSums = sets:fold(fun(Sum, Acc) ->
        lists:foldl(fun(Num, AccIn) ->
            sets:add_element(Sum + Num, AccIn)
        end, Acc, CurrentRow)
    end, sets:new(), PossibleSums),
    process_rows(Mat, Row - 1, Cols, NewSums).

find_min_diff([], _, MinDiff) -> MinDiff;
find_min_diff([Sum | Rest], Target, MinDiff) ->
    CurrentDiff = abs(Sum - Target),
    if
        CurrentDiff < MinDiff -> find_min_diff(Rest, Target, CurrentDiff);
        true -> find_min_diff(Rest, Target, MinDiff)
    end.