-module(solution).
-export([maximize_win/2]).

maximize_win(Points, k) ->
    MaxPoints = lists:max(Points),
    Length = length(Points),
    MaxWin = maximize_win_helper(Points, k, 0, 0, MaxPoints, Length, 0),
    MaxWin.

maximize_win_helper([], _, _, MaxWin, _, _, _) -> MaxWin;
maximize_win_helper(Points, K, Start, MaxWin, MaxPoints, Length, CurrentMax) ->
    if
        Start < Length ->
            NewMaxWin = max(CurrentMax, lists:sum(lists:sublist(Points, Start + 1))),
            maximize_win_helper(Points, K, Start + 1, NewMaxWin, MaxPoints, Length, NewMaxWin);
        true ->
            MaxWin
    end.