-module(longest_semi_rep).
-export([find_longest_semi_rep_substring/1]).

find_longest_semi_rep_substring(S) ->
    find_longest_semi_rep_substring(S, 0).

find_longest_semi_rep_substring(S, Acc) ->
    find_longest_semi_rep_substring(S, 0, 0, 0, Acc).

find_longest_semi_rep_substring(S, Start, End, DiffCount, Acc) ->
    Len = length(S),
    if End >= Len ->
        max(Acc, End - Start);
    true ->
        if End > Start, lists:nth(End, S) == lists:nth(End-1, S) ->
            find_longest_semi_rep_substring(S, Start, End+1, DiffCount, max(Acc, End+1 - Start));
        true ->
            if DiffCount < 1 ->
                find_longest_semi_rep_substring(S, Start, End+1, DiffCount + 1, max(Acc, End+1 - Start));
            true ->
                find_longest_semi_rep_substring(S, Start+1, Start+1, 0, max(Acc, End - Start))
            end
        end
    end.