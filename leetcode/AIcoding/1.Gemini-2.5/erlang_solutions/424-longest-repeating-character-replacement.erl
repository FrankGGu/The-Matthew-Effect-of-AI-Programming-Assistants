-module(solution).
-export([characterReplacement/2]).

characterReplacement(S, K) ->
    Len = length(S),
    characterReplacement_loop(S, K, Len, 0, 0, array:new({size, 26}, {default, 0}), 0).

characterReplacement_loop(S, K, Len, Left, Right, FreqMap, MaxFreq) when Right < Len ->
    Char = lists:nth(Right + 1, S),
    Idx = Char - $A,

    CurrentCharFreq = array:get(Idx, FreqMap),
    NewFreqMap = array:set(Idx, CurrentCharFreq + 1, FreqMap),

    NewMaxFreq = max(MaxFreq, CurrentCharFreq + 1),

    WindowSize = Right - Left + 1,

    if WindowSize - NewMaxFreq > K ->
        LeftChar = lists:nth(Left + 1, S),
        LeftIdx = LeftChar - $A,

        UpdatedFreqMap = array:set(LeftIdx, array:get(LeftIdx, NewFreqMap) - 1, NewFreqMap),

        characterReplacement_loop(S, K, Len, Left + 1, Right + 1, UpdatedFreqMap, NewMaxFreq);
    true ->
        characterReplacement_loop(S, K, Len, Left, Right + 1, NewFreqMap, NewMaxFreq)
    end;

characterReplacement_loop(_S, _K, _Len, Left, Right, _FreqMap, _MaxFreq) ->
    Right - Left.