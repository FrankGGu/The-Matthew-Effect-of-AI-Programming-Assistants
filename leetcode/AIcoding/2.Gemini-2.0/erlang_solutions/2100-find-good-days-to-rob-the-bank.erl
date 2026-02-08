-module(find_good_days).
-export([good_days_to_rob/2]).

good_days_to_rob(Security, Time) ->
    N = length(Security),
    if N < 2 * Time + 1 then
        []
    else
        good_days_to_rob_helper(Security, Time, 0, N, [])
    end.

good_days_to_rob_helper(Security, Time, I, N, Acc) ->
    if I + Time >= N then
        lists:reverse(Acc)
    else
        Left = lists:sublist(Security, I - Time + 1, 2 * Time + 1);
        case is_good_day(Left, Time) of
            true ->
                good_days_to_rob_helper(Security, Time, I + 1, N, [I | Acc]);
            false ->
                good_days_to_rob_helper(Security, Time, I + 1, N, Acc)
        end
    end.

is_good_day(List, Time) ->
    N = length(List),
    case N of
        0 -> false;
        _ ->
            Left = lists:sublist(List, 1, Time + 1);
            Right = lists:sublist(List, Time + 1, Time + 1);
            is_decreasing(Left) and is_increasing(Right)
    end.

is_decreasing([]) -> true;
is_decreasing([_]) -> true;
is_decreasing([H1, H2 | T]) ->
    if H1 >= H2 then
        is_decreasing([H2 | T])
    else
        false
    end.

is_increasing([]) -> true;
is_increasing([_]) -> true;
is_increasing([H1, H2 | T]) ->
    if H1 =< H2 then
        is_increasing([H2 | T])
    else
        false
    end.