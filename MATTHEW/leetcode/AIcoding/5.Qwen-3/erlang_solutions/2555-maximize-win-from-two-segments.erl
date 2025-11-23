-module(maximize_win_from_two_segments).
-export([solve/1]).

solve(Events) ->
    lists:sort(Events),
    solve(Events, 0, 0, 0, []).

solve([], _, _, Max, _) ->
    Max;
solve([H | T], Start, End, Max, Acc) ->
    case H of
        {Time, Type} when Type == 1 ->
            if
                Time > End ->
                    NewMax = max(Max, End - Start + 1),
                    solve(T, Time, Time, NewMax, []);
                true ->
                    solve(T, Start, Time, Max, [H | Acc])
            end;
        {Time, Type} when Type == 2 ->
            if
                Time > End ->
                    NewMax = max(Max, End - Start + 1),
                    solve(T, Time, Time, NewMax, []);
                true ->
                    solve(T, Start, Time, Max, [H | Acc])
            end
    end.