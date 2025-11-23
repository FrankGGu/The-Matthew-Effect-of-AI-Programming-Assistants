-module(most_frequent_prime).
-export([mostFrequentPrime/1]).

mostFrequentPrime(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Count = maps:new(),
    MaxCount = 0,
    PrimeMap = maps:new(),
    {_, _, Result} = lists:foldl(fun(I, {CountAcc, PrimeMapAcc, ResultAcc}) ->
        lists:foldl(fun(J, {CountAcc2, PrimeMapAcc2, ResultAcc2}) ->
            lists:foldl(fun(K, {CountAcc3, PrimeMapAcc3, ResultAcc3}) ->
                case I + K < Rows andalso J + K < Cols of
                    true ->
                    Size = K + 1,
                    Sum = sumSubmatrix(Matrix, I, J, Size),
                    if
                        is_prime(Sum) ->
                            NewCount = maps:get(Sum, CountAcc3, 0) + 1,
                            NewCountMap = maps:put(Sum, NewCount, CountAcc3),
                            {NewCountMap, PrimeMapAcc3, updateResult(ResultAcc3, Sum, NewCount)};
                        true ->
                            {CountAcc3, PrimeMapAcc3, ResultAcc3}
                    end;
                    false ->
                        {CountAcc3, PrimeMapAcc3, ResultAcc3}
                end
            end, {Count, PrimeMap, 0}, lists:seq(0, min(Rows - I, Cols - J) - 1))
        end, {Count, PrimeMap, 0}, lists:seq(0, Cols - 1))
    end, {Count, PrimeMap, 0}, lists:seq(0, Rows - 1)),
    Result.

sumSubmatrix(Matrix, I, J, Size) ->
    Sum = 0,
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, Acc2) ->
            Acc2 + element(I + X + 1, element(J + Y + 1, Matrix))
        end, Acc, lists:seq(0, Size - 1))
    end, Sum, lists:seq(0, Size - 1)).

is_prime(N) when N =< 1 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) -> is_prime(N, 3).

is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) -> is_prime(N, Div + 2).

updateResult(Current, Num, Count) ->
    case maps:get(Num, Current, 0) of
        C when C < Count -> maps:put(Num, Count, Current);
        _ -> Current
    end.