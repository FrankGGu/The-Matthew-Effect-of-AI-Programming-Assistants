-module(solution).
-export([max_average_ratio/2]).

max_average_ratio/2 ->
    {N, K} = {3, 2},
    Tasks = [{1, 2}, {2, 4}, {3, 9}],
    SortedTasks = lists:sort(fun({A, B}, {C, D}) -> 
        (B + 1) / (A + 1) - B / A > (D + 1) / (C + 1) - D / C 
    end, Tasks),
    average_ratio(SortedTasks, K, 0.0).

average_ratio([], _, Acc) -> Acc;
average_ratio([{A, B} | Rest], K, Acc) when K > 0 ->
    NewAcc = Acc + B / A,
    average_ratio(Rest, K - 1, NewAcc);
average_ratio([{A, B} | Rest], K, Acc) ->
    average_ratio(Rest, K, Acc + B / A).