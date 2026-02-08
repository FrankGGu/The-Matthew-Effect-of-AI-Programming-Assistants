-module(solution).
-export([preimageSizeFZF/1]).

preimageSizeFZF(K) ->
    X_found = find_x(K),
    if
        trailingZeroes(X_found) == K -> 5;
        true -> 0
    end.

find_x(K) ->
    Low = 0,
    High = 5 * K + 1,
    binary_search(Low, High, K, High).

binary_search(Low, High, K, AnsX) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    Zeroes = trailingZeroes(Mid),
    if
        Zeroes >= K ->
            binary_search(Low, Mid - 1, K, Mid);
        true -> % Zeroes < K
            binary_search(Mid + 1, High, K, AnsX)
    end;
binary_search(_Low, _High, _K, AnsX) ->
    AnsX.

trailingZeroes(N) ->
    trailingZeroes(N, 5, 0).

trailingZeroes(N, PowerOf5, Acc) when N >= PowerOf5 ->
    trailingZeroes(N, PowerOf5 * 5, Acc + N div PowerOf5);
trailingZeroes(_N, _PowerOf5, Acc) ->
    Acc.