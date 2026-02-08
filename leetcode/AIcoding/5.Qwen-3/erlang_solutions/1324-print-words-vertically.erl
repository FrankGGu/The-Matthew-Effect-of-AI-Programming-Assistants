-module(solution).
-export([vertical_text/1]).

vertical_text(S) ->
    Words = string:split(S, " ", all),
    MaxLength = lists:max([length(W) || W <- Words]),
    vertical_text(Words, MaxLength, []).

vertical_text([], _, Acc) ->
    lists:reverse(Acc);
vertical_text(Words, Length, Acc) ->
    CurrentLine = [lists:nth(Length, Word) || Word <- Words],
    NewAcc = [string:join(CurrentLine, "") | Acc],
    vertical_text(Words, Length - 1, NewAcc).

vertical_text([]) ->
    []; 
vertical_text(Words) ->
    MaxLength = lists:max([length(W) || W <- Words]),
    vertical_text(Words, MaxLength, []).