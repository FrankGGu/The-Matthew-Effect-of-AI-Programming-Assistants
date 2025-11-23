-module(knight_dialer).
-export([knight_dialer/1]).

knight_dialer(N) ->
    Mod = 1000000007,
    Moves = [
        [4, 6],    % 0
        [6, 8],     % 1
        [7, 9],     % 2
        [4, 8],     % 3
        [0, 3, 9],  % 4
        [],         % 5
        [0, 1, 7], % 6
        [2, 6],     % 7
        [1, 3],    % 8
        [2, 4]     % 9
    ],
    DP = lists:duplicate(10, 1),
    knight_dialer(N, 1, DP, Moves, Mod).

knight_dialer(N, Step, DP, _, _) when Step >= N ->
    lists:sum(DP) rem 1000000007;
knight_dialer(N, Step, DP, Moves, Mod) ->
    NewDP = lists:map(fun(Key) ->
        lists:foldl(fun(Move, Acc) ->
            (Acc + lists:nth(Move + 1, DP)) rem Mod
        end, 0, lists:nth(Key + 1, Moves))
    end, lists:seq(0, 9)),
    knight_dialer(N, Step + 1, NewDP, Moves, Mod).