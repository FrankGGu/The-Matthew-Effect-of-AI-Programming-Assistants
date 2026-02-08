-module(solution).
-export([maximum_strong_pair_xor/1]).

maximum_strong_pair_xor(Nums) ->
    Sorted = lists:sort(Nums),
    MaxXor = 0,
    Trie = {dict:new(), dict:new()},
    maximum_strong_pair_xor(Sorted, MaxXor, Trie).

maximum_strong_pair_xor([], MaxXor, _) -> MaxXor;
maximum_strong_pair_xor([Num | Rest], MaxXor, Trie) ->
    {NewTrie, CurrentMax} = insert_and_query(Num, Trie, MaxXor),
    maximum_strong_pair_xor(Rest, max(MaxXor, CurrentMax), NewTrie).

insert_and_query(Num, {Children, _} = Trie, MaxXor) ->
    {QueryTrie, CurrentMax} = query_trie(Num, Children, 30, 0, MaxXor),
    InsertTrie = insert_trie(Num, QueryTrie),
    {InsertTrie, CurrentMax}.

query_trie(_, _, -1, Current, MaxXor) -> {[], max(MaxXor, Current)};
query_trie(Num, Children, Bit, Current, MaxXor) ->
    BitVal = (Num bsr Bit) band 1,
    Desired = 1 - BitVal,
    case dict:find(Desired, Children) of
        {ok, Child} ->
            query_trie(Num, element(1, Child), Bit - 1, Current bor (1 bsl Bit), MaxXor);
        error ->
            case dict:find(BitVal, Children) of
                {ok, Child} ->
                    query_trie(Num, element(1, Child), Bit - 1, Current, MaxXor);
                error ->
                    {[], MaxXor}
            end
    end.

insert_trie(Num, {Children, _}) ->
    insert_trie(Num, Children, 30, {dict:new(), dict:new()}).

insert_trie(_, _, -1, Trie) -> Trie;
insert_trie(Num, ParentChildren, Bit, {Children, _} = Trie) ->
    BitVal = (Num bsr Bit) band 1,
    case dict:find(BitVal, ParentChildren) of
        {ok, Child} ->
            NewChild = insert_trie(Num, element(1, Child), Bit - 1, Child),
            NewChildren = dict:store(BitVal, NewChild, ParentChildren),
            {NewChildren, dict:new()};
        error ->
            NewChild = insert_trie(Num, dict:new(), Bit - 1, {dict:new(), dict:new()}),
            NewChildren = dict:store(BitVal, NewChild, ParentChildren),
            {NewChildren, dict:new()}
    end.