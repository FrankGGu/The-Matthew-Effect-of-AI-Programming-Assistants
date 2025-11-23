-module(solution).
-export([numWays/1]).

-define(MODULO, 1000000007).

numWays(Nums) ->
    LenNums = length(Nums),
    case LenNums of
        0 -> 0;
        1 -> 0;
        _ ->
            CombinationsTable = generate_combinations_table(LenNums - 1),
            (solve(Nums, CombinationsTable) - 1 + ?MODULO) rem ?MODULO
    end.

solve([], _CombinationsTable) -> 1;
solve([_], _CombinationsTable) -> 1;
solve(Nums, CombinationsTable) ->
    [Root | Rest] = Nums,
    {Left, Right} = partition(Rest, Root, [], []),
    LenLeft = length(Left),
    LenRight = length(Right),

    Combinations = get_combination(LenLeft + LenRight, LenLeft, CombinationsTable),

    WaysLeft = solve(Left, CombinationsTable),
    WaysRight = solve(Right, CombinationsTable),

    ((Combinations * WaysLeft) rem ?MODULO * WaysRight) rem ?MODULO.

partition([], _Root, LeftAcc, RightAcc) -> {lists:reverse(LeftAcc), lists:reverse(RightAcc)};
partition([H | T], Root, LeftAcc, RightAcc) when H < Root -> partition(T, Root, [H | LeftAcc], RightAcc);
partition([H | T], Root, LeftAcc, RightAcc) -> partition(T, Root, LeftAcc, [H | RightAcc]).

generate_combinations_table(MaxN) ->
    OuterArray = array:new([{size, MaxN + 1}, {fixed, true}]),

    Row0 = array:new([{size, 1}, {fixed, true}]),
    Row0_updated = array:set(0, 1, Row0),
    OuterArray_updated = array:set(0, Row0_updated, OuterArray),

    lists:foldl(fun(N, AccOuterArray) ->
        PrevRow = array:get(N - 1, AccOuterArray),

        CurrRow = array:new([{size, N + 1}, {fixed, true}]),

        CurrRow_updated = array:set(0, 1, CurrRow),

        CurrRow_updated2 = lists:foldl(fun(K, AccCurrRow) ->
            Val = (array:get(K - 1, PrevRow) + array:get(K, PrevRow)) rem ?MODULO,
            array:set(K, Val, AccCurrRow)
        end, CurrRow_updated, lists:seq(1, N - 1)),

        CurrRow_final = array:set(N, 1, CurrRow_updated2),

        array:set(N, CurrRow_final, AccOuterArray)
    end, OuterArray_updated, lists:seq(1, MaxN)).

get_combination(N, K, Table) ->
    RowN = array:get(N, Table),
    array:get(K, RowN).