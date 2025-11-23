-module(solution).
-export([stoneGameII/1]).

stoneGameII(Piles) ->
    N = length(Piles),
    SuffixSums = calculate_suffix_sums(Piles, N),

    {Result, _Memo} = solve(0, 1, N, SuffixSums, #{}).
    Result.

calculate_suffix_sums(Piles, N) ->
    lists:foldr(
        fun(Pile, {AccSum, Index, Map}) ->
            NewAccSum = AccSum + Pile,
            NewMap = Map#{Index => NewAccSum},
            {NewAccSum, Index - 1, NewMap}
        end,
        {0, N - 1, #{N => 0}},
        Piles
    )
    #3.
    .

solve(I, M, N, SuffixSums, Memo) ->
    if I >= N ->
        {0, Memo};
    true ->
        case maps:find({I, M}, Memo) of
            {ok, Result} ->
                {Result, Memo};
            error ->
                MaxX = min(2 * M, N - I),

                {FinalMaxStones, FinalMemo} = lists:foldl(
                    fun(X, {CurrentMax, AccMemo}) ->
                        StonesTaken = maps:get(I, SuffixSums) - maps:get(I + X, SuffixSums),

                        NewM = max(M, X),
                        {OpponentStones, UpdatedMemo} = solve(I + X, NewM, N, SuffixSums, AccMemo),

                        CurrentPlayerStonesFromRemaining = maps:get(I + X, SuffixSums) - OpponentStones,

                        TotalStonesForCurrentPlayer = StonesTaken + CurrentPlayerStonesFromRemaining,

                        {max(CurrentMax, TotalStonesForCurrentPlayer), UpdatedMemo}
                    end,
                    {-1, Memo},
                    lists:seq(1, MaxX)
                ),

                NewMemo = FinalMemo#{ {I, M} => FinalMaxStones },
                {FinalMaxStones, NewMemo}
        end
    end.