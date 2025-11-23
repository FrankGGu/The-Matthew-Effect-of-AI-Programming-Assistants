-module(count_special_subsequences).
-export([countSpecialSubsequences/1]).

countSpecialSubsequences(S) ->
    countSpecialSubsequences(S, 0, 0, 0, 0).

countSpecialSubsequences([], A, B, C, Count) ->
    Count;
countSpecialSubsequences([H | T], A, B, C, Count) ->
    case H of
        $a ->
            countSpecialSubsequences(T, A + 1, B, C, Count);
        $b ->
            NewB = B + A,
            countSpecialSubsequences(T, A, NewB, C, Count);
        $c ->
            NewC = C + B,
            countSpecialSubsequences(T, A, B, NewC, Count);
        _ ->
            countSpecialSubsequences(T, A, B, C, Count)
    end.