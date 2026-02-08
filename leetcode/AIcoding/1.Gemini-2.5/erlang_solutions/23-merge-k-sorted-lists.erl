-module(solution).
-export([mergeKLists/1]).

-spec merge(ListNode :: {integer(), any()} | nil, ListNode :: {integer(), any()} | nil) -> {integer(), any()} | nil.
merge(nil, L2) -> L2;
merge(L1, nil) -> L1;
merge({V1, N1} = L1, {V2, N2} = L2) when V1 =< V2 ->
    {V1, merge(N1, L2)};
merge({V1, N1} = L1, {V2, N2} = L2) ->
    {V2, merge(L1, N2)}.

-spec mergeKLists(Lists :: [{integer(), any()} | nil]) -> {integer(), any()} | nil.
mergeKLists(Lists) ->
    merge_all(Lists).

-spec merge_all(Lists :: [{integer(), any()} | nil]) -> {integer(), any()} | nil.
merge_all([]) -> nil;
merge_all([L]) -> L;
merge_all(Lists) ->
    merge_pairs(Lists).

-spec merge_pairs(Lists :: [{integer(), any()} | nil]) -> {integer(), any()} | nil.
merge_pairs(Lists) ->
    merge_pairs_acc(Lists, []).

-spec merge_pairs_acc(RemainingLists :: [{integer(), any()} | nil], MergedListsAcc :: [{integer(), any()} | nil]) -> {integer(), any()} | nil.
merge_pairs_acc([L1, L2 | Rest], Acc) ->
    merge_pairs_acc(Rest, [merge(L1, L2) | Acc]);
merge_pairs_acc([L | []], Acc) ->
    merge_all(lists:reverse([L | Acc]));
merge_pairs_acc([], Acc) ->
    merge_all(lists:reverse(Acc)).