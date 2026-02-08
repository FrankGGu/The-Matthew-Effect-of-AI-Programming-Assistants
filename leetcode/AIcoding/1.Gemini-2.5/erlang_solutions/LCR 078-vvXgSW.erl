-module(solution).
-export([mergeKLists/1]).

mergeKLists(Lists) ->
    do_merge(Lists).

do_merge([]) -> [];
do_merge([L]) -> L;
do_merge(Lists) ->
    MergedPairs = merge_pairs(Lists),
    do_merge(MergedPairs).

merge_pairs([]) -> [];
merge_pairs([L]) -> [L];
merge_pairs([L1, L2 | Rest]) ->
    [merge_two_lists(L1, L2) | merge_pairs(Rest)].

merge_two_lists([], L2) -> L2;
merge_two_lists(L1, []) -> L1;
merge_two_lists([H1|T1], [H2|T2]) when H1 =< H2 ->
    [H1 | merge_two_lists(T1, [H2|T2])];
merge_two_lists(L1, [H2|T2]) ->
    [H2 | merge_two_lists(L1, T2)].