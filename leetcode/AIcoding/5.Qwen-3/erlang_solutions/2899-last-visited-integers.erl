-module(last_visited_integers).
-export([f/1]).

f(Instructions) ->
    f(Instructions, [], []).

f([], _, Result) ->
    lists:reverse(Result);
f([H | T], [], Result) ->
    f(T, [H], Result);
f([H | T], Acc, Result) ->
    case is_integer(H) of
        true ->
            f(T, [H | Acc], Result);
        false ->
            f(T, [], [lists:reverse(Acc) | Result])
    end.