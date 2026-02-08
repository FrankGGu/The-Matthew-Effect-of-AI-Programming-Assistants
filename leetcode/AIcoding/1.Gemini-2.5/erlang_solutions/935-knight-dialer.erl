-module(knight_dialer).
-export([knight_dialer/1]).

-define(MOD, 1000000007).

knight_dialer(N) when N =< 0 -> 0;
knight_dialer(1) -> 10;
knight_dialer(N) ->
    Moves = #{
        0 => [4, 6],
        1 => [6, 8],
        2 => [7, 9],
        3 => [4, 8],
        4 => [0, 3, 9],
        5 => [],
        6 => [0, 1, 7],
        7 => [2, 6],
        8 => [1, 3],
        9 => [2, 4]
    },

    dp_prev = #{
        0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1,
        5 => 1, 6 => 1, 7 => 1, 8 => 1, 9 => 1
    },

    dp_final = lists:foldl(fun(_K_iter, AccDP) ->
        dp_next_init = maps:from_list([{Digit, 0} || Digit <- lists:seq(0, 9)]),

        maps:fold(fun(PrevDigit, Count, CurrentNextDP) ->
            case maps:get(PrevDigit, Moves) of
                [] -> CurrentNextDP;
                PossibleNextDigits ->
                    lists:foldl(fun(NextDigit, InnerNextDP) ->
                        maps:update_with(NextDigit, fun(OldVal) -> (OldVal + Count) rem ?MOD end, 0, InnerNextDP)
                    end, CurrentNextDP, PossibleNextDigits)
            end
        end, dp_next_init, AccDP)
    end, dp_prev, lists:seq(2, N)),

    Total = maps:fold(fun(_Digit, Count, Acc) ->
        (Acc + Count) rem ?MOD
    end, 0, dp_final),
    Total.