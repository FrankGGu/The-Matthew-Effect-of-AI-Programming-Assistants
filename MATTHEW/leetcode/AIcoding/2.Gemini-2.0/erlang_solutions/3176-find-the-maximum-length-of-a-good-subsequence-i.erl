-module(solution).
-export([max_length_good_subsequence/1]).

max_length_good_subsequence(Nums) ->
    max_length_good_subsequence(Nums, 0, 0).

max_length_good_subsequence([], _, Len) ->
    Len;
max_length_good_subsequence([H|T], Prev, Len) ->
    case H > Prev of
        true ->
            max(max_length_good_subsequence(T, Prev, Len),
                max_length_good_subsequence(T, H, Len + 1));
        false ->
            max_length_good_subsequence(T, Prev, Len)
    end.