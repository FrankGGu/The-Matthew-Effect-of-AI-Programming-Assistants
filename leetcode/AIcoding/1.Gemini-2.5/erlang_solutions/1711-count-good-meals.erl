-module(solution).
-export([countGoodMeals/1]).

countGoodMeals(Deliciousness) ->
    FreqMap = lists:foldl(fun(D, AccMap) ->
                                  maps:update_with(D, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, maps:new(), Deliciousness),

    PowersOfTwo = generate_powers_of_two(0, 21),

    MOD = 1000000000 + 7,

    TotalCount = maps:fold(fun(D1, C1, AccCount) ->
                                   lists:foldl(fun(P, InnerAccCount) ->
                                                       D2 = P - D1,
                                                       if D2 < D1 ->
                                                               InnerAccCount;
                                                          D2 == D1 ->
                                                               Pairs = (C1 * (C1 - 1) div 2) rem MOD,
                                                               (InnerAccCount + Pairs) rem MOD;
                                                          D2 > D1 ->
                                                               case maps:find(D2, FreqMap) of
                                                                   {ok, C2} ->
                                                                       Pairs = (C1 * C2) rem MOD,
                                                                       (InnerAccCount + Pairs) rem MOD;
                                                                   _ ->
                                                                       InnerAccCount
                                                               end
                                                       end
                                               end, AccCount, PowersOfTwo)
                           end, 0, FreqMap),
    TotalCount.

generate_powers_of_two(MinExp, MaxExp) ->
    generate_powers_of_two_rec(MinExp, MaxExp, []).

generate_powers_of_two_rec(Exp, MaxExp, Acc) when Exp > MaxExp ->
    lists:reverse(Acc);
generate_powers_of_two_rec(Exp, MaxExp, Acc) ->
    Power = 1 bsl Exp,
    generate_powers_of_two_rec(Exp + 1, MaxExp, [Power | Acc]).