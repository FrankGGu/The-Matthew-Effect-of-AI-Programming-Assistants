-module(count_pairs_xor_range).
-export([count_pairs/3]).

count_pairs(Nums, Low, High) ->
    Trie = trie_insert(Nums, create_trie()),
    count_pairs_helper(Nums, Low, High, Trie).

create_trie() ->
    #{0 => null, 1 => null, count => 0}.

trie_insert(Nums, Trie) ->
    lists:foldl(fun(Num, Acc) -> insert(Num, Acc) end, Trie, Nums).

insert(Num, Trie) ->
    insert_helper(Num, Trie, 14).

insert_helper(_, Trie, -1) ->
    #{Trie with count => Trie#{"count"} + 1};
insert_helper(Num, Trie, Bit) ->
    Val = (Num bsr Bit) band 1,
    NextTrie = maps:get(Val, Trie, null),
    NewTrie =
        case NextTrie of
            null ->
                insert_helper(Num, create_trie(), Bit - 1);
            _ ->
                insert_helper(Num, NextTrie, Bit - 1)
        end,
    #{Trie with Val => NewTrie, count => Trie#{"count"} + 1}.

count_pairs_helper(Nums, Low, High, Trie) ->
    lists:sum([count_less_equal(Num, High, Trie) - count_less_equal(Num, Low - 1, Trie) || Num <- Nums]).

count_less_equal(Num, Target, Trie) ->
    count_less_equal_helper(Num, Target, Trie, 14).

count_less_equal_helper(_, Trie, -1) ->
    Trie#{"count"};
count_less_equal_helper(Num, Target, Trie, Bit) ->
    NumBit = (Num bsr Bit) band 1,
    TargetBit = (Target bsr Bit) band 1,
    case TargetBit of
        1 ->
            ZeroTrie = maps:get(NumBit, Trie, null),
            OneTrie = maps:get(1 - NumBit, Trie, null),
            CountZero = case ZeroTrie of
                            null -> 0;
                            _ -> count_less_equal_helper(Num, Target, ZeroTrie, Bit - 1)
                        end,
            CountOne = case OneTrie of
                           null -> 0;
                           _ -> OneTrie#{"count"}
                       end,
            CountZero + CountOne;
        0 ->
            ZeroTrie = maps:get(NumBit, Trie, null),
            case ZeroTrie of
                null -> 0;
                _ -> count_less_equal_helper(Num, Target, ZeroTrie, Bit - 1)
            end
    end.