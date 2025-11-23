-module(solution).
-export([min_cost/1]).

overlap(W1, W2) when is_binary(W1), is_binary(W2) ->
    L1 = byte_size(W1),
    L2 = byte_size(W2),
    Limit = min(L1, L2),
    overlap_loop(W1, W2, L1, Limit, Limit, 0).

overlap_loop(_W1, _W2, _L1, _Limit, K, Acc) when K == 0 ->
    Acc;
overlap_loop(W1, W2, L1, _Limit, K, _Acc) ->
    Suffix = binary:part(W1, L1 - K, K),
    Prefix = binary:part(W2, 0, K),
    if Suffix == Prefix ->
        K;
    true ->
        overlap_loop(W1, W2, L1, _Limit, K - 1, 0)
    end.

min_cost(Words) ->
    N = length(Words),
    WordsBin = [list_to_binary(W) || W <- Words],

    OverlapMatrix = array:new([{fixed, true}, {size, N}]),
    OverlapMatrix1 = precompute_overlaps(WordsBin, N, OverlapMatrix, 0),

    TotalLength = lists:sum([byte_size(W) || W <- WordsBin]),

    MaxTotalOverlap = greedy_max_overlap(WordsBin, N, OverlapMatrix1),

    TotalLength - MaxTotalOverlap.

precompute_overlaps(WordsBin, N, AccMatrix, I) when I < N ->
    Row = array:new([{fixed, true}, {size, N}]),
    Row1 = precompute_row(WordsBin, N, I, Row, 0),
    AccMatrix1 = array:set(I, Row1, AccMatrix),
    precompute_overlaps(WordsBin, N, AccMatrix1, I + 1);
precompute_overlaps(_WordsBin, _N, AccMatrix, _I) ->
    AccMatrix.

precompute_row(WordsBin, N, I, AccRow, J) when J < N ->
    W1 = lists:nth(I + 1, WordsBin),
    W2 = lists:nth(J + 1, WordsBin),
    OverlapVal = overlap(W1, W2),
    AccRow1 = array:set(J, OverlapVal, AccRow),
    precompute_row(WordsBin, N, I, AccRow1, J + 1);
precompute_row(_WordsBin, _N, _I, AccRow, _J) ->
    AccRow.

greedy_max_overlap(_WordsBin, N, _OverlapMatrix, StartIdx, CurrentMaxTotalOverlap) when StartIdx == N ->
    CurrentMaxTotalOverlap;
greedy_max_overlap(WordsBin, N, OverlapMatrix, StartIdx, CurrentMaxTotalOverlap) ->
    CurrentWordIdx = StartIdx,
    UsedWords = sets:new(),
    UsedWords1 = sets:add_element(CurrentWordIdx, UsedWords),

    {PathOverlapSum, _LastWordIdx} = find_greedy_path(N, OverlapMatrix, CurrentWordIdx, UsedWords1, 1, 0),

    NewMaxTotalOverlap = max(CurrentMaxTotalOverlap, PathOverlapSum),
    greedy_max_overlap(WordsBin, N, OverlapMatrix, StartIdx + 1, NewMaxTotalOverlap).

find_greedy_path(N, _OverlapMatrix, LastWordIdx, _UsedWords, K, AccOverlapSum) when K == N ->
    {AccOverlapSum, LastWordIdx};
find_greedy_path(N, OverlapMatrix, LastWordIdx, UsedWords, K, AccOverlapSum) ->
    {BestNextWordIdx1, MaxOverlapForStep1} = find_best_next_word_in_step(N, OverlapMatrix, LastWordIdx, UsedWords, 0, -1, -1),

    if BestNextWordIdx1 == -1 ->
        {AccOverlapSum, LastWordIdx};
    true ->
        NewOverlapSum = AccOverlapSum + MaxOverlapForStep1,
        NewUsedWords = sets:add_element(BestNextWordIdx1, UsedWords),
        find_greedy_path(N, OverlapMatrix, BestNextWordIdx1, NewUsedWords, K + 1, NewOverlapSum)
    end.

find_best_next_word_in_step(N, OverlapMatrix, LastWordIdx, UsedWords, NextIdx, CurrentBestNextWordIdx, CurrentMaxOverlapForStep) when NextIdx == N ->
    {CurrentBestNextWordIdx, CurrentMaxOverlapForStep};
find_best_next_word_in_step(N, OverlapMatrix, LastWordIdx, UsedWords, NextIdx, CurrentBestNextWordIdx, CurrentMaxOverlapForStep) ->
    if not sets:is_element(NextIdx, UsedWords) ->
        Row = array:get(LastWordIdx, OverlapMatrix),
        CurrentOverlap = array:get(NextIdx, Row),
        if CurrentOverlap > CurrentMaxOverlapForStep ->
            find_best_next_word_in_step(N, OverlapMatrix, LastWordIdx, UsedWords, NextIdx + 1, NextIdx, CurrentOverlap);
        true ->
            find_best_next_word_in_step(N, OverlapMatrix, LastWordIdx, UsedWords, NextIdx + 1, CurrentBestNextWordIdx, CurrentMaxOverlapForStep)
        end;
    true ->
        find_best_next_word_in_step(N, OverlapMatrix, LastWordIdx, UsedWords, NextIdx + 1, CurrentBestNextWordIdx, CurrentMaxOverlapForStep)
    end.