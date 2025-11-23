-module(solution).
-export([maxLength/1]).

popcount(N) ->
    popcount(N, 0).

popcount(0, Count) -> Count;
popcount(N, Count) ->
    popcount(N band (N - 1), Count + 1). %% Brian Kernighan's algorithm

string_to_mask(S) ->
    string_to_mask(S, 0).

string_to_mask([], Mask) -> Mask;
string_to_mask([Char | Rest], CurrentMask) when Char >= $a, Char =< $z ->
    Bit = 1 bsl (Char - $a),
    string_to_mask(Rest, CurrentMask bor Bit).

preprocess(Arr) ->
    lists:foldl(fun(S, Acc) ->
        Mask = string_to_mask(S),
        Len = length(S),
        %% Only include strings that have unique characters (popcount equals length)
        %% and are not empty (empty string has mask 0, len 0, so it's valid, but doesn't add anything)
        if popcount(Mask) == Len ->
            [{Mask, Len} | Acc];
        true ->
            Acc
        end
    end, [], Arr).

backtrack(CurrentMask, CurrentLength, []) ->
    CurrentLength;
backtrack(CurrentMask, CurrentLength, [{NextMask, NextLen} | Rest]) ->
    %% Option 1: Exclude the current string
    MaxLenWithoutCurrent = backtrack(CurrentMask, CurrentLength, Rest),

    %% Option 2: Try to include the current string (if possible)
    if (CurrentMask band NextMask) == 0 -> %% Check if there are no common characters
           %% If no common characters, include it and recurse
           MaxLenWithCurrent = backtrack(CurrentMask bor NextMask, CurrentLength + NextLen, Rest),
           max(MaxLenWithoutCurrent, MaxLenWithCurrent);
       true -> %% Common characters found, cannot include this string
           MaxLenWithoutCurrent %% The maximum length is simply what we got from excluding it
       end.

maxLength(Arr) ->
    ValidStrings = preprocess(Arr),
    backtrack(0, 0, ValidStrings).