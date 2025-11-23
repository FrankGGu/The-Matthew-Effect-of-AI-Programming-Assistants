-module(solution).
-export([cal_points/1]).

cal_points(ops) ->
    cal_points(ops, []).

cal_points([], Scores) ->
    lists:sum(Scores);
cal_points([H | T], Scores) ->
    case H of
        "C" -> cal_points(T, tl(Scores));
        "D" -> cal_points(T, Scores ++ [2 * lists:last(Scores)]);
        "+" -> cal_points(T, Scores ++ [lists:last(Scores) + lists:nth(length(Scores), Scores)]);
        _ -> cal_points(T, Scores ++ [list_to_integer(H)])
    end.