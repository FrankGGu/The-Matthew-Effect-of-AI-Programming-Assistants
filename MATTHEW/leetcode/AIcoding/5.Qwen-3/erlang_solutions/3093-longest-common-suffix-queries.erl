-module(longest_common_suffix_queries).
-export([lcs/2]).

lcs(Queries, S) ->
    lists:map(fun(Q) -> lcs_query(Q, S) end, Queries).

lcs_query({A, B}, S) ->
    Max = min(A, B),
    lcs_helper(S, A, B, 0, Max).

lcs_helper(_, _, _, Count, 0) ->
    Count;
lcs_helper(S, A, B, Count, Len) ->
    case lists:nth(A - Len + 1, S) == lists:nth(B - Len + 1, S) of
        true ->
            lcs_helper(S, A, B, Count + 1, Len - 1);
        false ->
            Count
    end.