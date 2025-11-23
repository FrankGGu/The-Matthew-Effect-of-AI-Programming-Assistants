-module(rectangle_area_ii).
-export([rectangle_area/1]).

rectangle_area(Rectangles) ->
    solve(Rectangles).

solve(Rectangles) ->
    Xs = lists:usort(lists:foldl(fun([X1, Y1, X2, Y2], Acc) -> [X1, X2 | Acc] end, [], Rectangles)),
    N = length(Xs),
    Area = lists:foldl(fun(I, Acc) ->
        X = lists:nth(I, Xs),
        NextX = lists:nth(I+1, Xs),
        YIntervals = [],
        lists:foldl(fun([X1, Y1, X2, Y2], YIntervalsAcc) ->
            if X1 =< X andalso NextX =< X2 then
                [{Y1, Y2} | YIntervalsAcc]
            else
                YIntervalsAcc
            end
        end, YIntervals, Rectangles) ->
        Acc + (NextX - X) * calculate_union_length(lists:sort(YIntervals))
    end, 0, lists:seq(1, N-1)),
    Area rem (1000000000 + 7).

calculate_union_length(Intervals) ->
    calculate_union_length(Intervals, 0, -1, -1).

calculate_union_length([], Acc, _, _) ->
    Acc;
calculate_union_length([{Y1, Y2} | Rest], Acc, CurrentStart, CurrentEnd) ->
    if CurrentStart =:= -1 then
        calculate_union_length(Rest, Acc, Y1, Y2)
    else
        if Y1 =< CurrentEnd then
            NewCurrentEnd = max(CurrentEnd, Y2),
            calculate_union_length(Rest, Acc, CurrentStart, NewCurrentEnd)
        else
            calculate_union_length(Rest, Acc + (CurrentEnd - CurrentStart), Y1, Y2)
        end
    end.