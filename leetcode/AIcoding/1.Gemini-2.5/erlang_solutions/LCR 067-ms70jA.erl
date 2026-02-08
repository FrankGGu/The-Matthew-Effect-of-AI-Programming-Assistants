-module(solution).
-export([findMaximumXOR/1]).

insert(Trie, Num, Bit) when Bit >= 0 ->
    BitVal = (Num bsr Bit) band 1,

    ChildTrie = maps:get(BitVal, Trie, #{}),
    NewChildTrie = insert(ChildTrie, Num, Bit - 1),

    maps:put(BitVal, NewChildTrie, Trie);
insert(Trie, _Num, _Bit) ->
    Trie.

find_max_xor_for_num(Trie, Num, Bit) when Bit >= 0 ->
    BitVal = (Num bsr Bit) band 1,
    OppositeBitVal = BitVal bxor 1,

    CurrentXorBitValue = 1 bsl Bit,

    case maps:is_key(OppositeBitVal, Trie) of
        true ->
            CurrentXorBitValue + find_max_xor_for_num(maps:get(OppositeBitVal, Trie), Num, Bit - 1);
        false ->
            find_max_xor_for_num(maps:get(BitVal, Trie), Num, Bit - 1)
    end;
find_max_xor_for_num(_Trie, _Num, _Bit) ->
    0.

findMaximumXOR(Nums) ->
    MaxBit = 30,

    InitialTrie = #{},
    Trie = lists:foldl(fun(Num, AccTrie) ->
                            insert(AccTrie, Num, MaxBit)
                        end, InitialTrie, Nums),

    MaxXor = lists:foldl(fun(Num, CurrentMaxXor) ->
                            XorForNum = find_max_xor_for_num(Trie, Num, MaxBit),
                            max(CurrentMaxXor, XorForNum)
                         end, 0, Nums),
    MaxXor.