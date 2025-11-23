-module(solution).
-export([winnerSquareGame/1]).

winnerSquareGame(N) ->
    InitialDPArray = array:new([{size, N + 1}, {default, false}]),
    FinalDPArray = lists:foldl(
        fun(I, CurrentDPArray) ->
            MaxK = floor(math:sqrt(I)),
            CanWin = check_moves_for_I(1, MaxK, I, CurrentDPArray),
            array:set(I, CanWin, CurrentDPArray)
        end,
        InitialDPArray,
        lists:seq(1, N)
    ),
    array:get(N, FinalDPArray).

check_moves_for_I(K, MaxK, I, CurrentDPArray) when K =< MaxK ->
    StonesAfterMove = I - K*K,
    OpponentCanWin = array:get(StonesAfterMove, CurrentDPArray),
    if
        not OpponentCanWin ->
            true;
        true ->
            check_moves_for_I(K + 1, MaxK, I, CurrentDPArray)
    end;
check_moves_for_I(_K, _MaxK, _I, _CurrentDPArray) ->
    false.