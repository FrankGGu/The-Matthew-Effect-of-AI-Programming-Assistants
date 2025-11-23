-module(solution).
-export([num_friends_with_achievements/2]).

num_friends_with_achievements(Results, Target) ->
    count(Results, Target, 0).

count([], _, Count) ->
    Count;
count([H|T], Target, Count) ->
    if H == Target -> count(T, Target, Count + 1);
       true -> count(T, Target, Count)
    end.