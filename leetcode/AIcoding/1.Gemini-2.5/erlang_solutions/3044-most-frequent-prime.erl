-module(solution).
-export([mostFrequentPrime/1]).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) -> is_prime_check(N, 3).

is_prime_check(N, I) when I * I > N -> true;
is_prime_check(N, I) when N rem I == 0 -> false;
is_prime_check(N, I) -> is_prime_check(N, I + 2).

mostFrequentPrime(Mat) ->
    R_len = length(Mat),
    C_len = length(hd(Mat)),
    Directions = [{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}],

    AllNumbers = lists:foldl(fun(RowIdx, Acc1) ->
        lists:foldl(fun(ColIdx, Acc2) ->
            lists:foldl(fun({Dr, Dc}, Acc3) ->
                collect_numbers(Mat, R_len, C_len, RowIdx, ColIdx, Dr, Dc, 0, Acc3)
            end, Acc2, Directions)
        end, Acc1, lists:seq(0, C_len-1))
    end, [], lists:seq(0, R_len-1)),

    PrimeCounts = lists:foldl(fun(Num, Acc) ->
        if Num >= 10 andalso is_prime(Num) ->
            maps:update_with(Num, fun(Count) -> Count + 1 end, 1, Acc);
        true ->
            Acc
        end
    end, maps:new(), AllNumbers),

    find_most_frequent(PrimeCounts).

collect_numbers(Mat, R_len, C_len, CurR, CurC, Dr, Dc, CurrentNum, Acc) ->
    if CurR >= 0 andalso CurR < R_len andalso CurC >= 0 andalso CurC < C_len ->
        Val = lists:nth(CurC + 1, lists:nth(CurR + 1, Mat)),
        NewNum = CurrentNum * 10 + Val,
        collect_numbers(Mat, R_len, C_len, CurR + Dr, CurC + Dc, Dr, Dc, NewNum, [NewNum | Acc]);
    true ->
        Acc
    end.

find_most_frequent(PrimeCounts) ->
    case maps:to_list(PrimeCounts) of
        [] -> -1;
        List ->
            Sorted = lists:sort(fun({P1, F1}, {P2, F2}) ->
                if F1 == F2 -> P1 > P2;
                   true -> F1 > F2
                end
            end, List),
            {MostFrequentPrime, _} = hd(Sorted),
            MostFrequentPrime
    end.