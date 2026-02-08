-spec min_time(Time :: [integer()], M :: integer()) -> integer().
min_time(Time, M) ->
    Left = 1,
    Right = lists:sum(Time),
    binary_search(Time, M, Left, Right).

binary_search(Time, M, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    case can_finish(Time, M, Mid) of
        true -> binary_search(Time, M, Left, Mid);
        false -> binary_search(Time, M, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) ->
    Left.

can_finish(Time, M, Limit) ->
    can_finish(Time, M, Limit, 0, 0, 0).

can_finish([], _, _, _, Sum, _) ->
    Sum =< 0;
can_finish(_, 0, _, Max, Sum, _) ->
    Max + Sum =< 0;
can_finish([T | Rest], M, Limit, Max, Sum, Count) ->
    NewMax = max(Max, T),
    NewSum = Sum + T,
    if
        NewSum - NewMax =< Limit ->
            can_finish(Rest, M, Limit, NewMax, NewSum, Count + 1);
        true ->
            can_finish(Rest, M - 1, Limit, 0, 0, 0)
    end.