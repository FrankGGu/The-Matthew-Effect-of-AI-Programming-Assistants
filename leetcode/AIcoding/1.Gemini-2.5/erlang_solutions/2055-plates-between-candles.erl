-module(solution).
-export([platesBetweenCandles/2]).

platesBetweenCandles(S, Queries) ->
    N = byte_size(S),

    PrefixSumPlates = array:new([{size, N}, {fixed, true}, {default, 0}]),
    PrefixSumPlatesArray = build_prefix_sum_plates(S, N, 0, 0, PrefixSumPlates),

    NextCandle = array:new([{size, N}, {fixed, true}, {default, -1}]),
    NextCandleArray = build_next_candle(S, N, N - 1, -1, NextCandle),

    PrevCandle = array:new([{size, N}, {fixed, true}, {default, -1}]),
    PrevCandleArray = build_prev_candle(S, N, 0, -1, PrevCandle),

    process_queries(Queries, PrefixSumPlatesArray, NextCandleArray, PrevCandleArray).

build_prefix_sum_plates(_S, N, N, _CurrentPlates, AccArray) ->
    AccArray;
build_prefix_sum_plates(S, N, Idx, CurrentPlates, AccArray) ->
    Char = binary:at(S, Idx),
    NewCurrentPlates = case Char of
        $* -> CurrentPlates + 1;
        _ -> CurrentPlates
    end,
    UpdatedArray = array:set(Idx, NewCurrentPlates, AccArray),
    build_prefix_sum_plates(S, N, Idx + 1, NewCurrentPlates, UpdatedArray).

build_next_candle(_S, _N, -1, _LastCandlePos, AccArray) ->
    AccArray;
build_next_candle(S, N, Idx, LastCandlePos, AccArray) ->
    Char = binary:at(S, Idx),
    NewLastCandlePos = case Char of
        $| -> Idx;
        _ -> LastCandlePos
    end,
    UpdatedArray = array:set(Idx, NewLastCandlePos, AccArray),
    build_next_candle(S, N, Idx - 1, NewLastCandlePos, UpdatedArray).

build_prev_candle(_S, N, N, _FirstCandlePos, AccArray) ->
    AccArray;
build_prev_candle(S, N, Idx, FirstCandlePos, AccArray) ->
    Char = binary:at(S, Idx),
    NewFirstCandlePos = case Char of
        $| -> Idx;
        _ -> FirstCandlePos
    end,
    UpdatedArray = array:set(Idx, NewFirstCandlePos, AccArray),
    build_prev_candle(S, N, Idx + 1, NewFirstCandlePos, UpdatedArray).

process_queries([], _PrefixSumPlatesArray, _NextCandleArray, _PrevCandleArray) ->
    [];
process_queries([[Left, Right] | RestQueries], PrefixSumPlatesArray, NextCandleArray, PrevCandleArray) ->
    ActualLeftCandle = array:get(Left, NextCandleArray),
    ActualRightCandle = array:get(Right, PrevCandleArray),

    Result =
        if
            ActualLeftCandle == -1; ActualRightCandle == -1 ->
                0;
            ActualLeftCandle >= ActualRightCandle ->
                0;
            true ->
                PlatesBeforeRightCandle = array:get(ActualRightCandle, PrefixSumPlatesArray),
                PlatesBeforeLeftCandle = array:get(ActualLeftCandle, PrefixSumPlatesArray),
                PlatesBeforeRightCandle - PlatesBeforeLeftCandle
        end,
    [Result | process_queries(RestQueries, PrefixSumPlatesArray, NextCandleArray, PrevCandleArray)].