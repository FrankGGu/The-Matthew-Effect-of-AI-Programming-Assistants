-module(kth_largest).
-export([init/2, add/2]).

init(K, Nums) ->
    {lists:sort(Nums), K}.

add({SortedNums, K}, Val) ->
    NewSortedNums = insert(SortedNums, Val),
    {NewSortedNums, K},
    lists:nth(length(NewSortedNums) - K + 1, NewSortedNums).

insert([], Val) ->
    [Val];
insert([H|T], Val) when Val < H ->
    [Val, H|T];
insert([H|T], Val) ->
    [H|insert(T, Val)].