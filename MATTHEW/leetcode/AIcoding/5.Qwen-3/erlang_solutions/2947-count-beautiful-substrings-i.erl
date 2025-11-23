-module(solution).
-export([count_beautiful_substrings/1]).

count_beautiful_substrings(Str) ->
    N = length(Str),
    Count = 0,
    count_beautiful_substrings(Str, N, 0, Count).

count_beautiful_substrings(_, _, _, Count) when Count >= 0 -> Count;
count_beautiful_substrings(Str, N, I, Count) ->
    case I < N of
        true ->
            J = I + 1,
            count_beautiful_substrings(Str, N, J, Count);
        false ->
            Count
    end.