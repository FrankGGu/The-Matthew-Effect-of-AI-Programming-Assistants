-module(solution).
-export([countPairs/2]).

gcd(A, B) -> math:gcd(A, B).

get_divisors(N) ->
    get_divisors(N, 1, []).

get_divisors(N, I, Acc) when I * I < N ->
    case N rem I == 0 of
        true -> get_divisors(N, I + 1, [I, N div I | Acc]);
        false -> get_divisors(N, I + 1, Acc)
    end;
get_divisors(N, I, Acc) when I * I == N ->
    [I | Acc];
get_divisors(_N, _I, Acc) ->
    Acc.

countPairs(Nums, K) ->
    DivisorsK = lists:usort(get_divisors(K)), % Get unique divisors of K
    countPairs_loop(Nums, K, DivisorsK, 0, #{}).

countPairs_loop([], _K, _DivisorsK, TotalPairs, _CountsGcd) ->
    TotalPairs;
countPairs_loop([Num | RestNums], K, DivisorsK, TotalPairs, CountsGcd) ->
    G_i = gcd(Num, K),

    CurrentPairs = lists:foldl(fun(G_j, Acc) ->
                                   Count_G_j = maps:get(G_j, CountsGcd, 0),
                                   case Count_G_j > 0 andalso (G_i * G_j) rem K == 0 of
                                       true -> Acc + Count_G_j;
                                       false -> Acc
                                   end
                               end, 0, DivisorsK),

    NewTotalPairs = TotalPairs + CurrentPairs,

    OldCount_G_i = maps:get(G_i, CountsGcd, 0),
    NewCountsGcd = maps:put(G_i, OldCount_G_i + 1, CountsGcd),

    countPairs_loop(RestNums, K, DivisorsK, NewTotalPairs, NewCountsGcd).