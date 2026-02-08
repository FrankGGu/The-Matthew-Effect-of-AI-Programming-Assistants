-module(maximum_xor).
-export([find_maximum_xor/1]).

find_maximum_xor(Nums) ->
    Trie = lists:foldl(fun insert/2, trie(), Nums),
    lists:foldl(fun (Num, Max) -> max(Max, find_max_xor(Num, Trie)) end, 0, Nums).

insert(Num, Trie) ->
    insert(Num, Trie, 31).

insert(_, Trie, -1) ->
    Trie;
insert(Num, Trie, Bit) ->
    B = (Num bsr Bit) band 1,
    case maps:is_key(B, Trie) of
        true ->
            insert(Num, maps:get(B, Trie), Bit - 1);
        false ->
            insert(Num, maps:put(B, Trie, trie()), Bit - 1)
    end.

find_max_xor(Num, Trie) ->
    find_max_xor(Num, Trie, 31, 0).

find_max_xor(_, _, -1, Acc) ->
    Acc;
find_max_xor(Num, Trie, Bit, Acc) ->
    B = (Num bsr Bit) band 1,
    Opposite = 1 - B,
    case maps:is_key(Opposite, Trie) of
        true ->
            find_max_xor(Num, maps:get(Opposite, Trie), Bit - 1, Acc bor (1 bsl Bit));
        false ->
            find_max_xor(Num, maps:get(B, Trie), Bit - 1, Acc)
    end.

trie() ->
    #{}.