-module(solution).
-export([num_unique_good_subsequences/1]).

num_unique_good_subsequences(S) ->
    num_unique_good_subsequences(S, 0, 0, 0, 0).

num_unique_good_subsequences([], _, _, _, _) ->
    0;
num_unique_good_subsequences([C | T], i, a, b, c) ->
    case C of
        $a ->
            NewA = a + 1,
            NewB = b + a,
            NewC = c + b,
            num_unique_good_subsequences(T, i+1, NewA, NewB, NewC);
        $b ->
            NewB = b + 1,
            NewC = c + b,
            num_unique_good_subsequences(T, i+1, a, NewB, NewC);
        $c ->
            NewC = c + 1,
            num_unique_good_subsequences(T, i+1, a, b, NewC);
        _ ->
            num_unique_good_subsequences(T, i+1, a, b, c)
    end.