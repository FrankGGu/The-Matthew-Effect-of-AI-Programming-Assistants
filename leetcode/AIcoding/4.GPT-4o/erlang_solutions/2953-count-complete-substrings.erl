-module(solution).
-export([count_complete_substrings/1]).

count_complete_substrings(S) ->
    count_complete_substrings(S, 0, length(S)).

count_complete_substrings(S, Count, N) when N < 1 -> Count;
count_complete_substrings(S, Count, N) ->
    UniqueChars = lists:usort(string:to_list(S)),
    count_complete_substrings_helper(S, UniqueChars, Count, N, 0).

count_complete_substrings_helper(S, UniqueChars, Count, N, Start) ->
    case lists:nth(Start + 1, S) of
        none -> Count;
        _ -> 
            CompleteCount = count_complete(S, UniqueChars, Start, N, 0),
            count_complete_substrings_helper(S, UniqueChars, Count + CompleteCount, N, Start + 1)
    end.

count_complete(S, UniqueChars, Start, N, Acc) ->
    case lists:foldl(fun(Char, Acc) ->
        if
            lists:member(Char, string:to_list(lists:sublist(S, Start + 1, N - Start))) ->
                Acc + 1;
            true ->
                Acc
        end
    end, 0, UniqueChars) == length(UniqueChars) -> Acc + 1; 
    true -> Acc
    end.