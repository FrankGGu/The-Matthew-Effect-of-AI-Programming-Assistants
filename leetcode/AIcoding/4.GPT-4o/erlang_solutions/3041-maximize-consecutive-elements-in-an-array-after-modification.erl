-module(solution).
-export([max_consecutive_elements/2]).

max_consecutive_elements(A, K) ->
    Sorted = lists:sort(A),
    max_consecutive_elements(Sorted, K, 0, 0).

max_consecutive_elements([], _, _Max, Result) ->
    Result;
max_consecutive_elements([H | T], K, Max, Result) ->
    NewMax = max(Max, H + K),
    Count = count_consecutive([H | T], NewMax, K, 0),
    max_consecutive_elements(T, K, NewMax, max(Result, Count)).

count_consecutive([], _, _, Count) ->
    Count;
count_consecutive([H | T], Max, K, Count) when H =< Max ->
    count_consecutive(T, Max, K, Count + 1);
count_consecutive([H | _], Max, K, Count) when H > Max ->
    Count.