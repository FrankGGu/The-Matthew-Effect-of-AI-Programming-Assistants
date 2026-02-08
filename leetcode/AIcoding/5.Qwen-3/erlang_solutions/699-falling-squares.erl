-module(falling_squares).
-export([solve/1]).

solve(Queries) ->
    solve(Queries, [], 0, []).

solve([], _, _, Result) ->
    lists:reverse(Result);
solve([[Start, End] | T], Intervals, Height, Result) ->
    NewHeight = get_height(Intervals, Start, End),
    NewInterval = {Start, End, NewHeight},
    solve(T, [NewInterval | Intervals], Height + NewHeight, [NewHeight | Result]).

get_height([], _, _) ->
    0;
get_height([{S, E, H} | T], Start, End) ->
    if
        (S < End andalso E > Start) ->
            max(H, get_height(T, Start, End));
        true ->
            get_height(T, Start, End)
    end.