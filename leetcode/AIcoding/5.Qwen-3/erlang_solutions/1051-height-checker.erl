-module(height_checker).
-export([heightChecker/1]).

heightChecker(Height) ->
    Sorted = lists:sort(Height),
    count_diff(Height, Sorted, 0).

count_diff([], [], Acc) ->
    Acc;
count_diff([H|T], [S|Ss], Acc) ->
    if H =/= S -> count_diff(T, Ss, Acc + 1);
       true -> count_diff(T, Ss, Acc)
    end.