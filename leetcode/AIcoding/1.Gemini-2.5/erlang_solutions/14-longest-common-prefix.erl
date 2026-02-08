-module(solution).
-export([longest_common_prefix/1]).

longest_common_prefix([]) ->
    "";
longest_common_prefix([S]) ->
    S;
longest_common_prefix(Strs) ->
    SortedStrs = lists:sort(Strs),
    First = hd(SortedStrs),
    Last = lists:last(SortedStrs),
    compare_prefixes(First, Last).

compare_prefixes(S1, S2) ->
    compare_prefixes_acc(S1, S2, []).

compare_prefixes_acc([], _, Acc) ->
    lists:reverse(Acc);
compare_prefixes_acc(_, [], Acc) ->
    lists:reverse(Acc);
compare_prefixes_acc([H1|T1], [H2|T2], Acc) when H1 == H2 ->
    compare_prefixes_acc(T1, T2, [H1|Acc]);
compare_prefixes_acc(_, _, Acc) ->
    lists:reverse(Acc).