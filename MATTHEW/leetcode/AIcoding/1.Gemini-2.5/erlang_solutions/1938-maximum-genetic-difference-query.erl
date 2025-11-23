-module(solution).
-export([solve/3]).

solve(Parents, Nums, Queries) ->
    N = length(Parents),
    NumQueries = length(Queries),

    Adj0 = array:new(N),
    Adj = build_adj(Parents, Adj0),

    QueriesPerNode0 = array:new(N),
    QueriesPerNode = group_queries(Queries, QueriesPerNode0),

    RootNode = find_root(Parents),

    Results = array:new(NumQueries, {default, 0}),

    MaxBits = 17, 

    InitialTrie = #{},
    FinalResults = dfs(RootNode, InitialTrie, Adj, Nums, QueriesPerNode, MaxBits, Results),

    array:to_list(FinalResults).

build_adj(Parents, Adj) ->
    lists:foldl(fun({Parent, ChildIdx}, AccAdj) ->
                    case Parent of
                        -1 -> AccAdj;
                        _ -> array:set(Parent, [ChildIdx | array:get(Parent, AccAdj)], AccAdj)
                    end
                end, Adj, lists:zip(Parents, lists:seq(0, length(Parents) - 1))).

group_queries(Queries, QueriesPerNode) ->
    lists:foldl(fun({[Node, Val], QueryIdx}, AccQueriesPerNode) ->
                    array:set(Node, [{Val, QueryIdx} | array:get(Node, AccQueriesPerNode)], AccQueriesPerNode)
                end, QueriesPerNode, lists:zip(Queries, lists:seq(0, length(Queries) - 1))).

find_root(Parents) ->
    {_RootVal, RootIdx} = lists:keyfind(-1, 1, lists:zip(Parents, lists:seq(0, length(Parents) - 1))),
    RootIdx.

dfs(Node, CurrentTrie, Adj, Nums, QueriesPerNode, MaxBits, ResultsArray) ->
    NodeValue = array:get(Node, Nums),
    NewTrie = trie_add(CurrentTrie, NodeValue, MaxBits - 1),

    NodeQueries = array:get(Node, QueriesPerNode),
    ResultsAfterQueries = lists:foldl(fun({QVal, QIdx}, AccResults) ->
                                          MaxXor = trie_query(NewTrie, QVal, MaxBits - 1),
                                          array:set(QIdx, MaxXor, AccResults)
                                      end, ResultsArray, NodeQueries),

    Children = array:get(Node, Adj),
    lists:foldl(fun(Child, AccResults) ->
                    dfs(Child, NewTrie, Adj, Nums, QueriesPerNode, MaxBits, AccResults)
                end, ResultsAfterQueries, Children).

trie_add(Trie, Num, BitIdx) ->
    NewTrie = maps:update_with(count, fun(C) -> C + 1 end, 1, Trie),

    if BitIdx < 0 ->
        NewTrie;
    true ->
        Bit = (Num bsr BitIdx) band 1,
        Child = maps:get(Bit, NewTrie, #{}), 
        UpdatedChild = trie_add(Child, Num, BitIdx - 1),
        maps:put(Bit, UpdatedChild, NewTrie) 
    end.

trie_query(Trie, Num, BitIdx) ->
    if BitIdx < 0 ->
        0;
    true ->
        case maps:get(count, Trie, 0) of
            0 -> 0;
            _ ->
                TargetBit = (Num bsr BitIdx) band 1,
                OppositeBit = 1 - TargetBit,

                OppositeChild = maps:get(OppositeBit, Trie, #{}),
                SameChild = maps:get(TargetBit, Trie, #{}),

                OppositeChildCount = maps:get(count, OppositeChild, 0),
                SameChildCount = maps:get(count, SameChild, 0),

                if OppositeChildCount > 0 ->
                    (1 bsl BitIdx) bor trie_query(OppositeChild, Num, BitIdx - 1);
                SameChildCount > 0 ->
                    trie_query(SameChild, Num, BitIdx - 1);
                true ->
                    0
                end
        end
    end.