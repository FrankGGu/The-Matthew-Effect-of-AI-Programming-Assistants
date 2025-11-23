-module(solution).
-export([num_substrings/1]).

num_substrings(S) ->
    num_substrings(S, 0, 0).

num_substrings([], _, Acc) ->
    Acc;
num_substrings([C | T], Count, Acc) ->
    if
        C == $1 ->
            NewCount = Count + 1,
            num_substrings(T, NewCount, Acc + NewCount);
        true ->
            num_substrings(T, 0, Acc)
    end.