-module(solution).
-export([stoneGameVII/1]).

-spec generate_prefix_sums(list()) -> list().
generate_prefix_sums(List) ->
    generate_prefix_sums(List, 0, [0]).

generate_prefix_sums([], _, Acc) ->
    lists:reverse(Acc);
generate_prefix_sums([H|T], CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    generate_prefix_sums(T, NewSum, [NewSum|Acc]).

-spec stoneGameVII(list()) -> integer().
stoneGameVII(Stones) ->
    N = length(Stones),

    PrefixSumsList = generate_prefix_sums(Stones),
    PrefixSumsTuple = list_to_tuple(PrefixSumsList),

    Table = ets:new(dp_memo, [set, public, {read_concurrency, true}]),

    GetSum = fun(I, J) ->
        element(J+2, PrefixSumsTuple) - element(I+1, PrefixSumsTuple)
    end,

    DP_ets = fun F(I, J) ->
        if
            I >= J -> 0;
            true ->
                case ets:lookup(Table, {I, J}) of
                    [{_, _, Val}] -> Val;
                    [] ->
                        Score1 = GetSum(I+1, J) - F(I+1, J),
                        Score2 = GetSum(I, J-1) - F(I, J-1),

                        Result = max(Score1, Score2),
                        ets:insert(Table, {{I, J}, Result}),
                        Result
                end
        end
    end,

    FinalResult = DP_ets(0, N-1),
    ets:delete(Table),
    FinalResult.