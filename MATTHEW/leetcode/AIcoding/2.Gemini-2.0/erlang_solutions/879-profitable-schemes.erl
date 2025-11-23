-module(profitable_schemes).
-export([profitableSchemes/3]).

profitableSchemes(G, P, Group, Profit) ->
    N = length(Group),
    M = length(Profit),
    DP = array:new([G+1, P+1], {0}),
    array:set({0, 0}, 1, DP),
    Mod = 1000000007,
    lists:foldl(
        fun(I, AccDP) ->
            g(I, Group, Profit, AccDP, G, P, Mod)
        end,
        DP,
        lists:seq(1, N)
    ) # array.

g(I, Group, Profit, DP, G, P, Mod) ->
    Cost = lists:nth(I, Group),
    Earn = lists:nth(I, Profit),
    lists:foldl(
        fun(G0, AccDP) ->
            lists:foldl(
                fun(P0, AccDP2) ->
                    NewG = min(G, G0 + Cost),
                    NewP = min(P, P0 + Earn),
                    Val1 = array:get({G0, P0}, AccDP),
                    Val2 = array:get({NewG, NewP}, AccDP),
                    NewVal = (Val2 + Val1) rem Mod,
                    array:set({NewG, NewP}, NewVal, AccDP2)
                end,
                lists:seq(P, 0, -1),
                AccDP
            )
        end,
        lists:seq(G, 0, -1),
        DP
    ).