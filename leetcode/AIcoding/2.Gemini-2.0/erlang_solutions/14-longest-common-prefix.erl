-module(longest_common_prefix).
-export([longestCommonPrefix/1]).

longestCommonPrefix([]) -> "";
longestCommonPrefix([H|T]) ->
    lists:foldl(fun(S, Acc) -> commonPrefix(S, Acc) end, H, T).

commonPrefix(S1, S2) ->
    commonPrefix(S1, S2, []).

commonPrefix([], _, Acc) -> lists:reverse(Acc);
commonPrefix(_, [], Acc) -> lists:reverse(Acc);
commonPrefix([H1|T1], [H2|T2], Acc) ->
    if
        H1 == H2 ->
            commonPrefix(T1, T2, [H1|Acc]);
        true ->
            lists:reverse(Acc)
    end.