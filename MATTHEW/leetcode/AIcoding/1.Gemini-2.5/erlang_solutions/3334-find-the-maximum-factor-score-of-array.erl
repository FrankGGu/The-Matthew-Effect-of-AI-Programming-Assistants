-module(solution).
-export([max_factor_score/1]).

max_factor_score(Nums) ->
    lists:foldl(fun(Num, MaxAcc) ->
                    Score = get_factor_score(Num),
                    max(Score, MaxAcc)
                end, 0, Nums).

get_factor_score(N) ->
    get_factor_score_iter(N, 1, 0).

get_factor_score_iter(N, Divisor, Acc) when Divisor * Divisor > N ->
    Acc;
get_factor_score_iter(N, Divisor, Acc) when N rem Divisor == 0 ->
    NewAcc = if Divisor * Divisor == N -> Acc + Divisor;
                true -> Acc + Divisor + (N div Divisor)
             end,
    get_factor_score_iter(N, Divisor + 1, NewAcc);
get_factor_score_iter(N, Divisor, Acc) ->
    get_factor_score_iter(N, Divisor + 1, Acc).