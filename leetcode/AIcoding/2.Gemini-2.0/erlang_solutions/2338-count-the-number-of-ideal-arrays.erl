-module(ideal_arrays).
-export([solve/1]).

solve(N) ->
    solve(N, 10000).

solve(N, MaxValue) ->
    Mod = 1000000007,
    C = comb_table(N + MaxValue, N),
    Len = N,
    lists:foldl(
        fun(Num, Acc) ->
            Factors = prime_factors(Num),
            NumWays = lists:foldl(
                fun(Count, SubAcc) ->
                    (SubAcc * C[[Len - 1, Count + Len - 2]]) rem Mod
                end,
                1,
                Factors
            ),
            (Acc + NumWays) rem Mod
        end,
        0,
        lists:seq(1, MaxValue)
    ).

comb_table(N, K) ->
    Mod = 1000000007,
    Table = array:new([N + 1, K + 1], {fixed, 0}),
    array:set([0, 0], 1, Table),
    array:set([1, 0], 1, Table),
    array:set([1, 1], 1, Table),
    comb_table_helper(2, N, K, Table, Mod).

comb_table_helper(I, N, K, Table, Mod) when I > N ->
    Table;
comb_table_helper(I, N, K, Table, Mod) ->
    array:set([I, 0], 1, Table),
    array:set([I, I], 1, Table),
    comb_table_row_helper(I, 1, K, Table, Mod),
    comb_table_helper(I + 1, N, K, Table, Mod).

comb_table_row_helper(I, J, K, Table, Mod) when J > K ->
    ok;
comb_table_row_helper(I, J, K, Table, Mod) ->
    Val = (array:get([I - 1, J - 1], Table) + array:get([I - 1, J], Table)) rem Mod,
    array:set([I, J], Val, Table),
    comb_table_row_helper(I, J + 1, K, Table, Mod).

prime_factors(N) ->
    prime_factors(N, 2, []).

prime_factors(1, _, Acc) ->
    counts(Acc);
prime_factors(N, F, Acc) when F * F > N ->
    counts([N | Acc]);
prime_factors(N, F, Acc) when N rem F == 0 ->
    prime_factors(N div F, F, [F | Acc]);
prime_factors(N, F, Acc) ->
    prime_factors(N, F + 1, Acc).

counts(List) ->
    lists:foldl(
        fun(X, Acc) ->
            case maps:is_key(X, Acc) of
                true ->
                    maps:update(X, maps:get(X, Acc) + 1, Acc);
                false ->
                    maps:put(X, 1, Acc)
            end
        end,
        #{},
        List
    ).