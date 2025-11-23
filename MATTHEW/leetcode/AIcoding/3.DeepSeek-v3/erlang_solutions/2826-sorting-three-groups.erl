-module(solution).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
    N = length(Nums),
    DP = lists:duplicate(4, lists:duplicate(N + 1, 0)),
    {_, _, _, LastRow} = lists:foldl(fun(I, {Prev1, Prev2, Prev3, _}) ->
        Num = lists:nth(I, Nums),
        New1 = Prev1 + if Num =/= 1 -> 1; true -> 0 end,
        New2 = min(Prev1, Prev2) + if Num =/= 2 -> 1; true -> 0 end,
        New3 = min(min(Prev1, Prev2), Prev3) + if Num =/= 3 -> 1; true -> 0 end,
        {New1, New2, New3, {New1, New2, New3}}
    end, {0, 0, 0, {0, 0, 0}}, lists:seq(1, N)),
    {Res1, Res2, Res3} = LastRow,
    min(min(Res1, Res2), Res3).