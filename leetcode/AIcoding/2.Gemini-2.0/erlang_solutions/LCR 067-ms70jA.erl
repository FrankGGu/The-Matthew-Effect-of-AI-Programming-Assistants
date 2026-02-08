-module(max_xor).
-export([find_maximum_xor/1]).

find_maximum_xor(Nums) ->
    Trie = trie_insert(Nums, trie_new()),
    lists:foldl(fun(Num, MaxXor) ->
                        max(MaxXor, find_max_xor(Num, Trie))
                end, 0, Nums).

trie_new() ->
    #{0 => null, 1 => null}.

trie_insert([], Trie) ->
    Trie;
trie_insert([H|T], Trie) ->
    trie_insert_num(H, 31, Trie),
    trie_insert(T, Trie).

trie_insert_num(Num, -1, Trie) ->
    Trie;
trie_insert_num(Num, Bit, Trie) ->
    BitVal = (Num bsr Bit) band 1,
    case maps:get(BitVal, Trie, null) of
        null ->
            NewTrie = trie_new(),
            Trie#{BitVal => NewTrie} ,
            trie_insert_num(Num, Bit - 1, NewTrie);
        SubTrie ->
            trie_insert_num(Num, Bit - 1, SubTrie)
    end.

find_max_xor(Num, Trie) ->
    find_max_xor_helper(Num, 31, Trie, 0).

find_max_xor_helper(_, -1, _, CurrentXor) ->
    CurrentXor;
find_max_xor_helper(Num, Bit, Trie, CurrentXor) ->
    BitVal = (Num bsr Bit) band 1,
    OppositeBit = 1 - BitVal,
    case maps:get(OppositeBit, Trie, null) of
        null ->
            SubTrie = maps:get(BitVal, Trie),
            find_max_xor_helper(Num, Bit - 1, SubTrie, CurrentXor);
        SubTrie ->
            find_max_xor_helper(Num, Bit - 1, SubTrie, CurrentXor bor (OppositeBit bsl Bit))
    end.