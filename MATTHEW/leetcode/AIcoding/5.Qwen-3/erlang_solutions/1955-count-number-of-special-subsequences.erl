-module(count_number_of_special_subsequences).
-export([countSpecialSubsequences/1]).

countSpecialSubsequences(S) ->
    countSpecialSubsequences(S, 0, 0, 0).

countSpecialSubsequences([], a, b, c) ->
    a * b * c;
countSpecialSubsequences([H | T], a, b, c) ->
    case H of
        $a ->
            countSpecialSubsequences(T, a + 1, b, c);
        $b ->
            countSpecialSubsequences(T, a, b + a, c);
        $c ->
            countSpecialSubsequences(T, a, b, c + b)
    end.