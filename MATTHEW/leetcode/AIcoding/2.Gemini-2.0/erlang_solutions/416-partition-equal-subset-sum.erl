-module(partition_equal_subset_sum).
-export([can_partition/1]).

can_partition(Nums) ->
    Sum = lists:sum(Nums),
    if Sum rem 2 /= 0 then
        false
    else
        Target = Sum div 2,
        N = length(Nums),
        dp(N, Target, Nums)
    end.

dp(N, Target, Nums) ->
    DP = array:new([N + 1, Target + 1], {default, false}),
    array:set({0, 0}, true, DP),
    for(I = 1, I =< N, I++,
        (fun(I) ->
            Num = lists:nth(I - 1, Nums),
            for(J = 0, J =< Target, J++,
                (fun(J) ->
                    Prev = array:get({I - 1, J}, DP),
                    if Prev then
                        array:set({I, J}, true, DP)
                    end,
                    if J >= Num then
                        PrevMinusNum = array:get({I - 1, J - Num}, DP),
                        if PrevMinusNum then
                            array:set({I, J}, true, DP)
                        end
                    end
                end)())
        end)()),
    array:get({N, Target}, DP).