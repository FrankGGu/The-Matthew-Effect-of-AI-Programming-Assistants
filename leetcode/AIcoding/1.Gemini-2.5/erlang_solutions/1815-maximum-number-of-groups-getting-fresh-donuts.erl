-module(solution).
-export([maxFreshDonuts/2]).

maxFreshDonuts(BatchSize, Groups) ->
    %% 1. Calculate initial frequencies of remainders for all groups.
    %% Using an array for Freq because BatchSize is small and access by index is efficient.
    %% array:new(Size, {default, InitialValue})
    Freq = array:new(BatchSize, {default, 0}),
    UpdatedFreq = lists:foldl(
        fun(G, AccFreq) ->
            Rem = G rem BatchSize,
            array:set(Rem, array:get(Rem, AccFreq) + 1, AccFreq)
        end,
        Freq,
        Groups
    ),

    %% 2. Handle groups with remainder 0.
    %% These groups always contribute 1 to the fresh donut count, regardless of order.
    InitialFresh = array:get(0, UpdatedFreq),

    %% 3. Create CountsTuple for remainders 1 to BatchSize-1.
    %%    These are the counts that will be used in the dynamic programming.
    %%    lists:seq(1, BatchSize-1) generates [1, 2, ..., BatchSize-1].
    CountsList = [array:get(I, UpdatedFreq) || I <- lists:seq(1, BatchSize-1)],
    CountsTuple = list_to_tuple(CountsList),

    %% 4. Call the memoized DP function.
    %% The memo map is passed as an argument and updated in each recursive call.
    %% The result of memo_dp is {MaxFresh, UpdatedMemo}. We only need MaxFresh.
    {DpResult, _FinalMemo} = memo_dp(0, CountsTuple, BatchSize, #{}),

    %% The total maximum fresh donuts is the initial fresh donuts plus
    %% the maximum fresh donuts from the remaining groups.
    InitialFresh + DpResult.

memo_dp(CurrentRem, Counts, BatchSize, Memo) ->
    Key = {CurrentRem, Counts},
    case maps:find(Key, Memo) of
        {ok, Value} -> {Value, Memo};
        error ->
            %% Base case: If no groups left (all counts in CountsTuple are 0),
            %% no more fresh donuts can be obtained from these groups.
            IfAllZeros = lists:all(fun(X) -> X == 0 end, tuple_to_list(Counts)),
            if IfAllZeros ->
                {0, Memo};
            true ->
                %% Calculate MaxFresh by trying to pick each available remainder group.
                %% calculate_max_fresh returns {MaxFreshValue, UpdatedMemoMap}.
                {MaxFresh, FinalMemoForThisBranch} = calculate_max_fresh(CurrentRem, Counts, BatchSize, Memo),
                %% Store the calculated result in the memo map.
                NewMemo = maps:put(Key, MaxFresh, FinalMemoForThisBranch),
                {MaxFresh, NewMemo}
            end
    end.

calculate_max_fresh(CurrentRem, Counts, BatchSize, Memo) ->
    MaxFresh = 0,
    CurrentMemo = Memo,
    CountsList = tuple_to_list(Counts),

    %% Iterate through possible next groups (remainders 1 to BatchSize-1).
    %% lists:foldl accumulates {MaxFreshSoFar, MemoMapSoFar} across iterations.
    lists:foldl(
        fun(I, {AccMaxFresh, AccMemo}) -> %% I is the remainder value (1-indexed for lists:nth)
            Count_I = lists:nth(I, CountsList),
            if Count_I > 0 ->
                %% Create new counts tuple by decrementing Count_I.
                NewCountsList = lists:replace_nth(I, Count_I - 1, CountsList),
                NewCountsTuple = list_to_tuple(NewCountsList),

                %% Calculate the remainder after serving this group.
                NextRemCandidate = (CurrentRem + I) rem BatchSize,

                %% Determine if a fresh donut is obtained and the actual next remainder.
                {FreshIncrement, ActualNextRem} = if NextRemCandidate == 0 ->
                                                       {1, 0}; %% Got fresh donut, reset remainder for the next group.
                                                   true ->
                                                       {0, NextRemCandidate}
                                                   end,

                %% Recursive call to memo_dp.
                %% Pass AccMemo to the recursive call, and get updated memo back.
                {DpResult, UpdatedMemoFromRecur} = memo_dp(ActualNextRem, NewCountsTuple, BatchSize, AccMemo),

                %% Update MaxFresh for this branch.
                {max(AccMaxFresh, FreshIncrement + DpResult), UpdatedMemoFromRecur};
            true ->
                %% No groups of this remainder type left, just pass current accumulated values.
                {AccMaxFresh, AccMemo}
            end
        end,
        {MaxFresh, CurrentMemo}, %% Initial accumulator for foldl: {MaxFreshSoFar, MemoMapSoFar}
        lists:seq(1, BatchSize - 1)
    ).