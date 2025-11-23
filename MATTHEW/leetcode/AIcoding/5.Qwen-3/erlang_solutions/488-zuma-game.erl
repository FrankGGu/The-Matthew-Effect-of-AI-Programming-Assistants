-module(zuma_game).
-export([process/1]).

process(Guess) ->
    process(Guess, 0).

process([], _) ->
    0;
process([H | T], Count) ->
    case is_same(H, T) of
        true ->
            process(T, Count + 1);
        false ->
            process(T, Count)
    end.

is_same(_, []) ->
    true;
is_same(A, [B | _]) when A =:= B ->
    true;
is_same(_, _) ->
    false.