-module(knight_dialer).
-export([knight_dialer/1]).

knight_dialer(N) ->
    Mod = 1000000007,
    Memo = dict:new(),

    dial(N, Mod, Memo).

dial(N, Mod, Memo) ->
    lists:foldl(fun(Digit, Acc) ->
                       Acc + memoized_count(Digit, N, Mod, Memo)
                   end, 0, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) rem Mod.

memoized_count(Digit, N, Mod, Memo) ->
    case dict:find({Digit, N}, Memo) of
        {ok, Count} ->
            Count;
        error ->
            Count = count(Digit, N, Mod, Memo),
            Memo2 = dict:store({Digit, N}, Count, Memo),
            dict:fetch({Digit, N}, Memo2)
    end.

count(Digit, 0, _, _) ->
    0;
count(Digit, 1, _, _) ->
    1;
count(Digit, N, Mod, Memo) ->
    NextDigits = next_digits(Digit),
    lists:foldl(fun(NextDigit, Acc) ->
                       Acc + memoized_count(NextDigit, N - 1, Mod, Memo)
                   end, 0, NextDigits) rem Mod.

next_digits(0) -> [4, 6];
next_digits(1) -> [6, 8];
next_digits(2) -> [7, 9];
next_digits(3) -> [4, 8];
next_digits(4) -> [0, 3, 9];
next_digits(5) -> [];
next_digits(6) -> [0, 1, 7];
next_digits(7) -> [2, 6];
next_digits(8) -> [1, 3];
next_digits(9) -> [2, 4].