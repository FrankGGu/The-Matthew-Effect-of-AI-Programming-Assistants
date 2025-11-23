-module(solution).
-export([make_string_sorted/1]).

make_string_sorted(S) ->
    N = length(S),
    Fact = lists:foldl(fun(I, Acc) -> [ (lists:nth(1, Acc) * I) rem 1000000007 | Acc ] end, [1], lists:seq(1, N)),
    Factorial = lists:reverse(Fact),
    Count = maps:new(),
    Count1 = lists:foldl(fun(C, Map) -> 
        maps:update_with(C, fun(V) -> V + 1 end, 1, Map) 
    end, Count, S),
    Res = 0,
    calculate(S, N, Factorial, Count1, Res).

calculate([], _, _, _, Res) -> Res;
calculate([C | Rest], N, Factorial, Count, Res) ->
    Keys = maps:keys(Count),
    Sorted = lists:sort(Keys),
    Denominator = 1,
    Denominator1 = lists:foldl(fun(Key, Acc) -> 
        (Acc * lists:nth(maps:get(Key, Count), Factorial)) rem 1000000007 
    end, Denominator, Sorted),
    Smaller = lists:takewhile(fun(X) -> X < C end, Sorted),
    Temp = 0,
    Temp1 = lists:foldl(fun(Key, Sum) -> 
        CountKey = maps:get(Key, Count),
        NewCount = maps:update(Key, CountKey - 1, Count),
        if CountKey == 1 -> 
            NewCount1 = maps:remove(Key, NewCount);
        true -> 
            NewCount1 = NewCount
        end,
        Denominator2 = 1,
        Denominator3 = lists:foldl(fun(K, Acc2) -> 
            (Acc2 * lists:nth(maps:get(K, NewCount1), Factorial)) rem 1000000007 
        end, Denominator2, lists:sort(maps:keys(NewCount1))),
        FactN = lists:nth(N, Factorial),
        InvDenominator = modinv(Denominator3, 1000000007),
        Add = (FactN * InvDenominator) rem 1000000007,
        (Sum + Add) rem 1000000007
    end, Temp, Smaller),
    NewRes = (Res + Temp1) rem 1000000007,
    CountC = maps:get(C, Count),
    if CountC == 1 -> 
        NewCount = maps:remove(C, Count);
    true -> 
        NewCount = maps:update(C, CountC - 1, Count)
    end,
    calculate(Rest, N - 1, Factorial, NewCount, NewRes).

modinv(A, M) ->
    {G, X, _} = extended_gcd(A, M),
    if G =/= 1 -> 
        -1;
    true -> 
        (X rem M + M) rem M
    end.

extended_gcd(A, 0) -> {A, 1, 0};
extended_gcd(A, B) ->
    {G, X, Y} = extended_gcd(B, A rem B),
    {G, Y, X - (A div B) * Y}.