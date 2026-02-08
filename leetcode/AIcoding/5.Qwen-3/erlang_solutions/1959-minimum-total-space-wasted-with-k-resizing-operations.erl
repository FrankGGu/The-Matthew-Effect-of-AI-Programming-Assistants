-module(solution).
-export([min_space_wasted_k_resizing/3]).

min_space_wasted_k_resizing(Nums, K, _Config) ->
    N = length(Nums),
    MaxK = K,
    lists:reverse(Nums, []),
    P = lists:seq(0, N+1) -- [N+1],
    DP = array:new(N+1, {default, array:new(MaxK+2, {default, 16#3f3f3f3f})}),
    array:set(0, array:set(0, 0, array:new(MaxK+2, {default, 16#3f3f3f3f}))), 
    lists:foldl(fun(I, DPAcc) ->
        lists:foldl(fun(J, DPAccI) ->
            lists:foldl(fun(R, _) ->
                Val = array:get(R, array:get(I-1, DPAcc)),
                CurrMax = 0,
                Sum = 0,
                if R =< MaxK ->
                    lists:foldl(fun(T, _) ->
                        CurrMax = max(CurrMax, lists:nth(T+1, Nums)),
                        Sum = Sum + CurrMax - lists:nth(T+1, Nums),
                        NewVal = min(Val + Sum, array:get(R+1, array:get(T, DPAccI))),
                        array:set(R+1, NewVal, array:get(T, DPAccI))
                    end, 0, lists:seq(I, J));
                true -> ok
                end
            end, 0, lists:seq(0, MaxK)),
            DPAccI
        end, DPAcc, lists:seq(0, N))
    end, DP, lists:seq(1, N)),
    Res = lists:foldl(fun(E, Acc) -> min(Acc, array:get(K, E)) end, 16#3f3f3f3f, array:to_list(DP)),
    Res.