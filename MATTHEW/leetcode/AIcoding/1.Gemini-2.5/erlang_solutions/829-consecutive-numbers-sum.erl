-module(solution).
-export([consecutiveNumbersSum/1]).

consecutiveNumbersSum(N) ->
    Q = odd_part(N),
    count_divisors(Q).

odd_part(N) ->
    N div (N band (-N)).

count_divisors(Q) ->
    count_divisors_recursive(Q, 1, 0).

count_divisors_recursive(Q, I, Count) when I * I < Q ->
    case Q rem I of
        0 -> count_divisors_recursive(Q, I + 1, Count + 2);
        _ -> count_divisors_recursive(Q, I + 1, Count)
    end;
count_divisors_recursive(Q, I, Count) when I * I == Q ->
    Count + 1;
count_divisors_recursive(_Q, _I, Count) ->
    Count.