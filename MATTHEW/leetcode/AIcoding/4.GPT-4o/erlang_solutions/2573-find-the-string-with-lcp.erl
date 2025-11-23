-module(solution).
-export([find_lcp/1]).

find_lcp(Strs) ->
    case lists:foldl(fun(X, Acc) -> lcp(X, Acc) end, hd(Strs), tl(Strs)) of
        "" -> -1;
        Lcp -> Lcp
    end.

lcp(Str1, Str2) ->
    lcp_helper(Str1, Str2, 0).

lcp_helper(Str1, Str2, N) when N < min(length(Str1), length(Str2)) ->
    if
        lists:nth(N + 1, Str1) =:= lists:nth(N + 1, Str2) ->
            lcp_helper(Str1, Str2, N + 1);
        true ->
            lists:sublist(Str1, 1, N)
    end;
lcp_helper(_, _, N) ->
    lists:sublist(Str1, 1, N).