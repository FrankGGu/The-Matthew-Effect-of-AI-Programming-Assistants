-module(baseball_game).
-export([cal_points/1]).

cal_points(Points) ->
    cal_points(Points, []).

cal_points([], Acc) ->
    lists:sum(Acc);
cal_points([H | T], Acc) ->
    case H of
        "C" ->
            cal_points(T, tl(Acc));
        "D" ->
            [Prev | _] = Acc,
            cal_points(T, [Prev * 2 | Acc]);
        "+" ->
            [Prev1, Prev2 | _] = Acc,
            cal_points(T, [Prev1 + Prev2 | Acc]);
        _ ->
            Num = list_to_integer(H),
            cal_points(T, [Num | Acc])
    end.