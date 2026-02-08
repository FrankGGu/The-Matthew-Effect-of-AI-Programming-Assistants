-module(solution).
-export([count_substrings/3]).

count_substrings(S, K, C) ->
    N = length(S),
    count_substrings(S, K, C, N, 0).

count_substrings(S, K, C, N, Count) when N > 0 ->
    count_substrings(S, K, C, N - 1, Count + count_at_length(S, N, K, C));
count_substrings(_, _, _, 0, Count) ->
    Count.

count_at_length(S, N, K, C) ->
    counts(0, 0, S, N, K, C).

counts(Start, End, S, Length, K, C) when End < Length ->
    if
        valid_substring(S, Start, End, K, C) ->
            1 + counts(Start, End + 1, S, Length, K, C);
        true ->
            counts(Start, End + 1, S, Length, K, C)
    end;
counts(Start, End, S, Length, K, C) when End >= Length ->
    0.

valid_substring(S, Start, End, K, C) ->
    Substring = lists:nthlist(Start + 1, End - Start),
    Count = maps:get(C, lists:foldl(fun Ch, Acc -> maps:update_with(Ch, fun(X) -> X + 1 end, 1, Acc) end, #{}, Substring)),
    maps:size(Count) =< K.