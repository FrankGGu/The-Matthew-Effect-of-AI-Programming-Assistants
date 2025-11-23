-module(solution).
-export([sumFourDivisors/1]).

sumFourDivisors(Nums) ->
    lists:foldl(fun(N, Acc) ->
        Acc + get_divisors_sum(N)
    end, 0, Nums).

get_divisors_sum(N) ->
    MaxI = trunc(math:sqrt(N)),
    {Count, Sum} = find_divisors(1, MaxI, N, 0, 0),
    case Count of
        4 -> Sum;
        _ -> 0
    end.

find_divisors(I, MaxI, N, CurrentCount, CurrentSum) when I =< MaxI ->
    case N rem I of
        0 ->
            NewCount = CurrentCount + 1,
            NewSum = CurrentSum + I,
            case I * I == N of
                true ->
                    find_divisors(I + 1, MaxI, N, NewCount, NewSum);
                false ->
                    find_divisors(I + 1, MaxI, N, NewCount + 1, NewSum + (N div I))
            end;
        _ ->
            find_divisors(I + 1, MaxI, N, CurrentCount, CurrentSum)
    end;
find_divisors(_I, _MaxI, _N, CurrentCount, CurrentSum) ->
    {CurrentCount, CurrentSum}.