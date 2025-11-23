-module(solution).
-export([longest_subsequence/2]).

longest_subsequence(Binary, K) ->
    longest_subsequence(Binary, K, 0, 0).

longest_subsequence([], _K, Count, _) ->
    Count;
longest_subsequence([H | T], K, Count, Current) ->
    NewCurrent = Current * 2 + H,
    case NewCurrent =< K of
        true -> longest_subsequence(T, K, Count + 1, NewCurrent);
        false -> longest_subsequence(T, K, Count, Current)
    end.