-module(solution).
-export([find_maximum_xor/1]).

-record(trie, {zero = undefined, one = undefined}).

-spec insert(integer(), Trie :: any()) -> any().
insert(Num, Trie) ->
    insert(Num, Trie, 31).

insert(_, Trie, -1) ->
    Trie;
insert(Num, #trie{zero = Z, one = O} = Trie, Bit) ->
    B = (Num bsr Bit) band 1,
    case B of
        0 ->
            NewZ = case Z of
                undefined -> insert(Num, #trie{}, Bit - 1);
                _ -> insert(Num, Z, Bit - 1)
            end,
            Trie#trie{zero = NewZ};
        1 ->
            NewO = case O of
                undefined -> insert(Num, #trie{}, Bit - 1);
                _ -> insert(Num, O, Bit - 1)
            end,
            Trie#trie{one = NewO}
    end.

-spec query(integer(), Trie :: any()) -> integer().
query(Num, Trie) ->
    query(Num, Trie, 31, 0).

query(_, _, -1, Acc) ->
    Acc;
query(Num, #trie{zero = Z, one = O}, Bit, Acc) ->
    B = (Num bsr Bit) band 1,
    case B of
        0 ->
            case O of
                undefined -> query(Num, Z, Bit - 1, Acc);
                _ -> query(Num, O, Bit - 1, (Acc bor (1 bsl Bit)))
            end;
        1 ->
            case Z of
                undefined -> query(Num, O, Bit - 1, Acc);
                _ -> query(Num, Z, Bit - 1, (Acc bor (1 bsl Bit)))
            end
    end.

-spec find_maximum_xor([integer()]) -> integer().
find_maximum_xor([]) -> 0;
find_maximum_xor([H | T]) ->
    Trie = insert(H, #trie{}),
    find_maximum_xor(T, Trie, H, 0).

-spec find_maximum_xor([integer()], Trie :: any(), integer(), integer()) -> integer().
find_maximum_xor([], _, _, MaxXor) -> MaxXor;
find_maximum_xor([H | T], Trie, _, MaxXor) ->
    NewXor = query(H, Trie),
    UpdatedTrie = insert(H, Trie),
    find_maximum_xor(T, UpdatedTrie, H, max(MaxXor, NewXor)).
