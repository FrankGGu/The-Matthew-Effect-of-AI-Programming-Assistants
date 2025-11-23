-module(maximum_square_area_by_removing_fences_from_a_field).
-export([main/0]).

main() ->
    Input = io:get_line([]),
    [NStr, MStr] = string:split(Input, " "),
    N = list_to_integer(NStr),
    M = list_to_integer(MStr),
    X = lists:map(fun(_) -> list_to_integer(io:get_line([])) end, lists:seq(1, N)),
    Y = lists:map(fun(_) -> list_to_integer(io:get_line([])) end, lists:seq(1, M)),
    XSorted = lists:sort(X),
    YSorted = lists:sort(Y),
    MaxSide = max_side(XSorted, YSorted),
    io:format("~p~n", [MaxSide * MaxSide]).

max_side([], _) -> 0;
max_side(_, []) -> 0;
max_side([X | Xs], [Y | Ys]) ->
    if
        X == Y -> 1 + max_side(Xs, Ys);
        X < Y -> max_side(Xs, [Y | Ys]);
        true -> max_side([X | Xs], Ys)
    end.