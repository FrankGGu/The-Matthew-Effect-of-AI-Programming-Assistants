-module(solution).
-export([find_array/1]).

find_array(S) ->
    find_array(S, 0, []).

find_array([], _, Acc) ->
    lists:reverse(Acc);
find_array(S, Start, Acc) ->
    [Min | Rest] = lists:sort(S),
    NewAcc = [Min | Acc],
    Sum = lists:sum(NewAcc),
    NewS = subtract(Rest, Sum),
    find_array(NewS, Start + 1, NewAcc).

subtract([], _) ->
    [];
subtract([H | T], Val) ->
    if
        H == Val -> subtract(T, Val);
        true -> [H | subtract(T, Val)]
    end.