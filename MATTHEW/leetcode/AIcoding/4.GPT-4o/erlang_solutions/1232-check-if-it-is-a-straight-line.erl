-module(solution).
-export([check_straight_line/1]).

check_straight_line(Points) ->
    case length(Points) of
        2 -> true;
        _ -> check(Points, hd(Points), tl(Points))
    end.

check([], _, _) -> true;
check([{X0, Y0} | Tail], {X1, Y1}, {X2, Y2}) ->
    Det = (X1 - X0) * (Y2 - Y0) - (Y1 - Y0) * (X2 - X0),
    if
        Det /= 0 -> false;
        true -> check(Tail, {X1, Y1}, {X2, Y2})
    end.