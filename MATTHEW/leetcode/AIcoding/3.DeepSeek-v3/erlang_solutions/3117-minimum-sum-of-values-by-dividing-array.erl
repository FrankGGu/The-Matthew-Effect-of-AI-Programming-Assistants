-module(solution).
-export([minimum_sum/2]).

minimum_sum(Nums, K) ->
    N = length(Nums),
    DP = array:new([{size, N + 1}, {default, infinity}]),
    DP1 = array:set(0, 0, DP),
    {_, Res} = lists:foldl(fun(I, {Dp, _}) ->
        Max = 0,
        Sum = 0,
        {NewDp, NewMax, NewSum} = lists:foldl(fun(J, {D, M, S}) ->
            JIndex = I - J,
            if
                JIndex < 0 -> {D, M, S};
                true ->
                    Num = lists:nth(JIndex + 1, Nums),
                    NewM = max(M, Num),
                    NewS = S + Num,
                    Cost = if
                        NewS =< K -> NewM * J;
                        true -> infinity
                    end,
                    Current = array:get(I, D),
                    NewVal = min(Current, array:get(JIndex, D) + Cost),
                    {array:set(I, NewVal, D), NewM, NewS}
            end
        end, {Dp, Max, Sum}, lists:seq(1, min(I, N))),
        {NewDp, array:get(N, NewDp)}
    end, {DP1, infinity}, lists:seq(1, N)),
    if
        Res == infinity -> -1;
        true -> Res
    end.