-module(solution).
-export([kInversePairs/2]).

kInversePairs(N, K) ->
    Mod = 1000000007,

    DpPrev = array:set(0, 1, array:new(K+1, 0)),

    FinalDpPrev = lists:foldl(
        fun(I, CurrentDpPrev) ->
            DpCurr = array:new(K+1, 0),

            DpCurrWith0 = array:set(0, array:get(0, CurrentDpPrev), DpCurr),

            lists:foldl(
                fun(J, AccDpCurr) ->
                    Val = (array:get(J-1, AccDpCurr) + array:get(J, CurrentDpPrev)) rem Mod,

                    SubtractVal = if J >= I -> array:get(J-I, CurrentDpPrev);
                                     true -> 0
                                  end,

                    FinalVal = (Val - SubtractVal + Mod) rem Mod,
                    array:set(J, FinalVal, AccDpCurr)
                end,
                DpCurrWith0,
                lists:seq(1, K)
            )
        end,
        DpPrev,
        lists:seq(1, N)
    ),

    array:get(K, FinalDpPrev).