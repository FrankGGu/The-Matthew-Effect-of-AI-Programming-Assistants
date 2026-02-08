-module(solution).
-export([judgePoint24/1]).

judgePoint24(Nums) ->
    FloatNums = [float(N) || N <- Nums],
    solve(FloatNums).

solve([N]) ->
    abs(N - 24.0) < 1e-6;
solve(Nums) ->
    Len = length(Nums),
    lists:any(fun(I) ->
        {Left, Right} = lists:split(I, Nums),
        lists:any(fun(J) ->
            {L, R} = lists:split(J, Right),
            N1 = lists:nth(1, Left),
            N2 = lists:nth(1, R),
            Rest = Left ++ tl(R),
            solve([N1 + N2 | Rest]) orelse
            solve([N1 - N2 | Rest]) orelse
            solve([N2 - N1 | Rest]) orelse
            (N2 /= 0 andalso solve([N1 * N2 | Rest])) orelse
            (N2 /= 0 andalso solve([N1 / N2 | Rest])) orelse
            (N1 /= 0 andalso solve([N2 / N1 | Rest]))
        end, lists:seq(1, Len - 1))
    end, lists:seq(1, Len - 1)).