-module(solution).
-export([grayCode/1]).

grayCode(N) ->
    grayCode_iter(0, N, [0]).

grayCode_iter(I, N, Acc) when I < N ->
    Shift = 1 bsl I,
    ReversedAcc = lists:reverse(Acc),
    NewElements = [X + Shift || X <- ReversedAcc],
    grayCode_iter(I + 1, N, Acc ++ NewElements);
grayCode_iter(_I, _N, Acc) ->
    Acc.