-module(solution).
-export([max_divisibility_score/1]).

max_divisibility_score(Numbers) ->
    max_divisibility_score(Numbers, 0, 0, 0).

max_divisibility_score([], _Score, _BestNum, _MaxCount) ->
    _BestNum;
max_divisibility_score([N | Rest], Score, BestNum, MaxCount) ->
    Count = count_divisors(N),
    if
        Count > MaxCount ->
            max_divisibility_score(Rest, Score, N, Count);
        Count == MaxCount ->
            max_divisibility_score(Rest, Score, min(BestNum, N), Count);
        true ->
            max_divisibility_score(Rest, Score, BestNum, MaxCount)
    end.

count_divisors(N) ->
    count_divisors(N, 1, 0).

count_divisors(_, Divisor, Count) when Divisor > N ->
    Count;
count_divisors(N, Divisor, Count) ->
    case N rem Divisor of
        0 -> count_divisors(N, Divisor + 1, Count + 1);
        _ -> count_divisors(N, Divisor + 1, Count)
    end.