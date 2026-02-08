-module(longest_common_suffix_queries).
-export([solve/1]).

solve(Queries) ->
    solve(Queries, []).

solve([], Acc) ->
    lists:reverse(Acc);
solve([{S1, S2} | Rest], Acc) ->
    Acc1 = [longest_common_suffix(S1, S2) | Acc],
    solve(Rest, Acc1).

longest_common_suffix(S1, S2) ->
    S1_list = string:to_list(S1),
    S2_list = string:to_list(S2),
    longest_common_suffix(S1_list, S2_list, 0).

longest_common_suffix([], _, Len) -> Len;
longest_common_suffix(_, [], Len) -> Len;
longest_common_suffix(S1, S2, Len) ->
    Len1 = length(S1),
    Len2 = length(S2),
    if
        Len1 == 0 orelse Len2 == 0 ->
            Len;
        true ->
            Last1 = lists:last(S1),
            Last2 = lists:last(S2),
            if
                Last1 == Last2 ->
                    S1_new = lists:sublist(S1, 1, Len1 - 1),
                    S2_new = lists:sublist(S2, 1, Len2 - 1),
                    longest_common_suffix(S1_new, S2_new, Len + 1);
                true ->
                    Len
            end
    end.