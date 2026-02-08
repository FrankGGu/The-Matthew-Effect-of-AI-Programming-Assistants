-module(solution).
-export([countPairs/3]).

-record(trie_node, {children = #{}, count = 0}).

new_trie_node() ->
    #trie_node{}.

insert(Trie, Num, MaxBitIndex) ->
    insert_recursive(Trie, Num, MaxBitIndex).

insert_recursive(Node, _, -1) ->
    Node#trie_node{count = Node#trie_node.count + 1};
insert_recursive(Node, Num, BitIndex) ->
    Bit = (Num bsr BitIndex) band 1,
    CurrentChild = maps:get(Bit, Node#trie_node.children, new_trie_node()),
    NewChild = insert_recursive(CurrentChild, Num, BitIndex - 1),
    NewChildren = maps:put(Bit, NewChild, Node#trie_node.children),
    Node#trie_node{children = NewChildren, count = Node#trie_node.count + 1}.

count_less_than_or_equal(Trie, Num, Limit, MaxBitIndex) ->
    count_less_than_or_equal_recursive(Trie, Num, Limit, MaxBitIndex).

count_less_than_or_equal_recursive(Node, _, _, -1) ->
    Node#trie_node.count;
count_less_than_or_equal_recursive(Node, Num, Limit, BitIndex) ->
    if Node == new_trie_node() ->
        0;
    true ->
        NumBit = (Num bsr BitIndex) band 1,
        LimitBit = (Limit bsr BitIndex) band 1,

        Child0 = maps:get(0, Node#trie_node.children, new_trie_node()),
        Child1 = maps:get(1, Node#trie_node.children, new_trie_node()),

        if NumBit == 0 ->
            if LimitBit == 1 ->
                Child0#trie_node.count + count_less_than_or_equal_recursive(Child1, Num, Limit, BitIndex - 1);
            else -> % LimitBit == 0
                count_less_than_or_equal_recursive(Child0, Num, Limit, BitIndex - 1)
            end;
        true -> % NumBit == 1
            if LimitBit == 1 ->
                Child1#trie_node.count + count_less_than_or_equal_recursive(Child0, Num, Limit, BitIndex - 1);
            else -> % LimitBit == 0
                count_less_than_or_equal_recursive(Child1, Num, Limit, BitIndex - 1)
            end
        end
    end.

countPairs(Nums, Low, High) ->
    MaxBitIndex = 17, % Max value for nums[i] is 2*10^5. 2^17 = 131072, 2^18 = 262144. So we need bits 0 to 17.

    {_, CountHigh} = calculate_count(Nums, High, MaxBitIndex),
    {_, CountLowMinus1} = calculate_count(Nums, Low - 1, MaxBitIndex),

    CountHigh - CountLowMinus1.

calculate_count(Nums, Limit, MaxBitIndex) ->
    lists:foldl(fun(Num, {Trie, TotalCount}) ->
        CurrentCount = count_less_than_or_equal(Trie, Num, Limit, MaxBitIndex),
        NewTrie = insert(Trie, Num, MaxBitIndex),
        {NewTrie, TotalCount + CurrentCount}
    end, {new_trie_node(), 0}, Nums).