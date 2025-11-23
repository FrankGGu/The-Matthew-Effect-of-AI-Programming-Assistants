-module(solve).
-export([heights'12/1].

heights'12(Books) ->
    dp(Books, 0, 0, 0).

dp([], Acc, _, _) ->
    Acc;
dp([[W,H] | T], Acc, CurrentWidth, CurrentHeight) ->
    if
        CurrentWidth + W > 30 ->
            dp(T, Acc + CurrentHeight, W, H);
        true ->
            dp(T, Acc, CurrentWidth + W, max(CurrentHeight, H))
    end.