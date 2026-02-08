-module(solution).
-export([maximize_win/2]).

maximize_win(Nums, K) ->
    SortedNums = lists:sort(Nums),
    MaxWin = maximize_win_helper(SortedNums, K, 0, 0, length(SortedNums)),
    MaxWin.

maximize_win_helper([], _, _, MaxCurrent, _) -> 
    MaxCurrent;
maximize_win_helper([H | T], K, MaxCurrent, Count, Total) -> 
    NewCount = Count + 1,
    NewMaxCurrent = max(MaxCurrent, NewCount),
    if 
        H - hd(T) > K -> 
            maximize_win_helper(T, K, NewMaxCurrent, NewCount, Total)
        ; 
            maximize_win_helper(T, K, NewMaxCurrent, NewCount, Total)
    end.