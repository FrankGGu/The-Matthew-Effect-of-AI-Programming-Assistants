-module(solution).
-export([num_squares/1]).

num_squares(N) when N < 1 -> 0;
num_squares(N) ->
    InitialDP = array:new([{size, N + 1}, {default, N + 1}]),
    DP0 = array:set(0, 0, InitialDP),

    FinalDP = lists:foldl(
        fun(I, CurrentDP) ->
            MaxJ = floor(math:sqrt(I)),
            MinVal = lists:foldl(
                fun(J, Acc) ->
                    Square = J * J,
                    Val = array:get(I - Square, CurrentDP) + 1,
                    min(Acc, Val)
                end,
                N + 1,
                lists:seq(1, MaxJ)
            ),
            array:set(I, MinVal, CurrentDP)
        end,
        DP0,
        lists:seq(1, N)
    ),

    array:get(N, FinalDP).