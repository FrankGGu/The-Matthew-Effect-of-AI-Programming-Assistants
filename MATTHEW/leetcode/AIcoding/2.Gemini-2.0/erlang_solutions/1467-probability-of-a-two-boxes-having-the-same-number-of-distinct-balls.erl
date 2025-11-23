-module(same_balls).
-export([same_balls/1]).

same_balls(balls) ->
    N = length(balls),
    TotalBalls = lists:sum(balls),
    HalfTotalBalls = TotalBalls div 2,

    {Factorials, InverseFactorials} = precompute_factorials(TotalBalls),

    distinct_balls(balls, N, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls).

distinct_balls(balls, N, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls) ->
    AllCombinations = comb(balls, N, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls),

    TotalCombinations = binomial(TotalBalls, HalfTotalBalls, Factorials, InverseFactorials),

    AllCombinations / TotalCombinations.

comb(balls, N, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls) ->
    comb(balls, N, 0, 0, 1, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls).

comb(_, _, _, HalfTotalBalls, Count, _, _, _, _) ->
    Count;
comb([], _, _, _, Count, _, _, _, _) ->
    Count;
comb([Ball | Rest], N, UsedBalls, Box1Balls, Count, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls) ->
    MaxTake = min(Ball, HalfTotalBalls - Box1Balls),

    comb_helper(Ball, Rest, N, UsedBalls, Box1Balls, Count, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls, MaxTake, 0).

comb_helper(Ball, Rest, N, UsedBalls, Box1Balls, Count, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls, MaxTake, Take) when Take =< MaxTake ->
    NewBox1Balls = Box1Balls + Take,
    NewUsedBalls = UsedBalls + 1,
    NewCount = Count * binomial(Ball, Take, Factorials, InverseFactorials),
    comb(Rest, N, NewUsedBalls, NewBox1Balls, NewCount, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls) +
    comb_helper(Ball, Rest, N, UsedBalls, Box1Balls, Count, Factorials, InverseFactorials, TotalBalls, HalfTotalBalls, MaxTake, Take + 1);
comb_helper(_, _, _, _, _, Count, _, _, _, _, _, _) ->
    0.

binomial(N, K, Factorials, InverseFactorials) ->
    if K < 0 orelse K > N ->
        0;
    true ->
        Factorials[N+1] * InverseFactorials[K+1] * InverseFactorials[N-K+1]
    end.

precompute_factorials(N) ->
    Factorials = precompute_factorials_helper(N, [1], 1, 1),
    InverseFactorials = precompute_inverse_factorials(Factorials),
    {Factorials, InverseFactorials}.

precompute_factorials_helper(0, Acc, _, _) ->
    lists:reverse(Acc);
precompute_factorials_helper(N, Acc, I, Fact) ->
    NewFact = Fact * I,
    precompute_factorials_helper(N-1, [NewFact | Acc], I+1, NewFact).

precompute_inverse_factorials(Factorials) ->
    Max = length(Factorials) - 1,
    InverseMax = fast_pow(Factorials[Max+1], 1000000007 - 2, 1000000007),
    precompute_inverse_factorials_helper(Factorials, [InverseMax], Max, InverseMax, 1000000007).

precompute_inverse_factorials_helper(_, Acc, 0, _, _) ->
    lists:reverse(Acc);
precompute_inverse_factorials_helper(Factorials, Acc, N, Inverse, Mod) ->
    NewInverse = (Inverse * N) rem Mod,
    precompute_inverse_factorials_helper(Factorials, [NewInverse | Acc], N-1, NewInverse, Mod).

fast_pow(Base, Exp, Mod) ->
    fast_pow_helper(Base, Exp, 1, Mod).

fast_pow_helper(_, 0, Result, _) ->
    Result;
fast_pow_helper(Base, Exp, Result, Mod) ->
    if (Exp band 1) == 1 ->
        NewResult = (Result * Base) rem Mod;
    true ->
        NewResult = Result
    end,
    NewBase = (Base * Base) rem Mod,
    NewExp = Exp bsr 1,
    fast_pow_helper(NewBase, NewExp, NewResult, Mod).