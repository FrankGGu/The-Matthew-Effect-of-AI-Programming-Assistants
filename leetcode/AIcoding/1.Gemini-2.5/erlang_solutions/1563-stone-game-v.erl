-module(solution).
-export([stoneGameV/1]).

stoneGameV(Stones) ->
    N = length(Stones),
    PrefixSumsTuple = calculate_prefix_sums_tuple(Stones),

    Memo = ets:new(dp_memo, [set, protected, {read_concurrency, true}]),

    Result = solve(0, N - 1, PrefixSumsTuple, Memo),
    ets:delete(Memo),
    Result.

calculate_prefix_sums_tuple(Stones) ->
    PrefixSumsList = lists:foldl(fun(X, Acc) -> Acc ++ [lists:last(Acc) + X] end, [0], Stones),
    list_to_tuple(PrefixSumsList).

solve(I, J, PrefixSumsTuple, Memo) ->
    case I == J of
        true -> 0;
        false ->
            case ets:lookup(Memo, {I, J}) of
                [{_, Score}] -> Score;
                [] ->
                    MaxScore = calculate_max_score(I, J, PrefixSumsTuple, Memo),
                    ets:insert(Memo, {{I, J}, MaxScore}),
                    MaxScore
            end
    end.

calculate_max_score(I, J, PrefixSumsTuple, Memo) ->
    lists:foldl(fun(K, AccMaxScore) ->
        SumLeft = get_sum_from_tuple(I, K, PrefixSumsTuple),
        SumRight = get_sum_from_tuple(K + 1, J, PrefixSumsTuple),

        CurrentScore = 
            if 
                SumLeft < SumRight ->
                    SumLeft + solve(I, K, PrefixSumsTuple, Memo);
                SumLeft > SumRight ->
                    SumRight + solve(K + 1, J, PrefixSumsTuple, Memo);
                true -> % SumLeft == SumRight
                    SumLeft + max(solve(I, K, PrefixSumsTuple, Memo), solve(K + 1, J, PrefixSumsTuple, Memo))
            end,

        max(AccMaxScore, CurrentScore)
    end, 0, lists:seq(I, J - 1)).

get_sum_from_tuple(StartIdx, EndIdx, PrefixSumsTuple) ->
    element(EndIdx + 2, PrefixSumsTuple) - element(StartIdx + 1, PrefixSumsTuple).