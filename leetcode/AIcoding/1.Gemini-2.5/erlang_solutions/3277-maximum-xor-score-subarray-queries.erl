-module(solution).
-export([solve/0]).

-record(trie_node, {child0 = 0, child1 = 0, count = 0}).

-define(MAX_BITS, 29). % 0-indexed bit, so highest bit is 29 for 30 bits.

-define(TRIE_NODES_TABLE, trie_nodes_table).
-define(FENWICK_ROOTS_TABLE, fenwick_roots_table).

solve() ->
    % LeetCode will provide input via standard I/O or function arguments.
    % This placeholder assumes direct function call with data.
    % Example:
    % Nums = [6, 6, 1, 7, 1],
    % M = 3,
    % Queries = [[0, 4], [0, 1], [1, 3], [2, 4], [0, 4]],
    % solve_problem(Nums, M, Queries).
    ok. % Placeholder for actual LeetCode environment.

solve_problem(Nums, M, Queries) ->
    N = length(Nums),
    PrefixXor = calculate_prefix_xor(Nums, N),

    ets:new(?TRIE_NODES_TABLE, [set, public]),
    ets:new(?FENWICK_ROOTS_TABLE, [set, public]),

    GroupedQueries = group_queries_by_R(Queries, N),

    NumQueries = length(Queries),
    Results = array:new(NumQueries, -1),

    TrieNodeCounter = 0,

    FinalResults = process_k_loop(0, N, PrefixXor, M, GroupedQueries, Results, TrieNodeCounter),

    ets:delete(?TRIE_NODES_TABLE),
    ets:delete(?FENWICK_ROOTS_TABLE),

    array:to_list(FinalResults).

calculate_prefix_xor(Nums, N) ->
    PrefixXor = array:new(N + 1, 0), % P[0] = 0
    calculate_prefix_xor_loop(Nums, 0, N, 0, PrefixXor).

calculate_prefix_xor_loop([], _I, _N, _CurrentXor, PrefixXor) ->
    PrefixXor;
calculate_prefix_xor_loop([H|T], I, N, CurrentXor, PrefixXor) ->
    NewXor = CurrentXor bxor H,
    NewPrefixXor = array:set(I + 1, NewXor, PrefixXor),
    calculate_prefix_xor_loop(T, I + 1, N, NewXor, NewPrefixXor).

group_queries_by_R(Queries, N) ->
    Grouped = array:new(N, []), % R can be from 0 to N-1
    group_queries_by_R_loop(Queries, 0, Grouped).

group_queries_by_R_loop([], _Idx, Grouped) ->
    Grouped;
group_queries_by_R_loop([[L, R]|T], Idx, Grouped) ->
    CurrentList = array:get(R, Grouped),
    NewList = [{L, Idx} | CurrentList],
    NewGrouped = array:set(R, NewList, Grouped),
    group_queries_by_R_loop(T, Idx + 1, NewGrouped).

process_k_loop(K, N, PrefixXor, M, GroupedQueries, Results, TrieNodeCounter) ->
    if K > N ->
        Results;
    else
        % Add P[K] to Fenwick tree. Fenwick tree covers P[0]...P[N], so N+1 elements.
        % Fenwick tree indices 1-based, so map P[K] to Fenwick index K+1.
        % Fenwick tree size is N+1 (number of elements) + 1 (for 1-based indexing)
        FenwickSize = N + 1, % Max Fenwick index is N+1.
        ValToAdd = array:get(K, PrefixXor),
        {NewTrieNodeCounter, _} = fenwick_update(K + 1, ValToAdd, K, TrieNodeCounter, FenwickSize),

        UpdatedResults = 
            if K > 0 -> % Queries with R_i = K-1 are processed when K is the current right endpoint for P[K]
                QueriesAtR = array:get(K - 1, GroupedQueries),
                process_queries_at_R(QueriesAtR, K, PrefixXor, M, Results, NewTrieNodeCounter, FenwickSize);
            else
                Results
            end,

        process_k_loop(K + 1, N, PrefixXor, M, GroupedQueries, UpdatedResults, NewTrieNodeCounter)
    end.

process_queries_at_R([], _K, _PrefixXor, _M, Results, _TrieNodeCounter, _FenwickSize) ->
    Results;
process_queries_at_R([{L, OriginalIdx}|T], K, PrefixXor, M, Results, TrieNodeCounter, FenwickSize) ->
    % Query for P[K] against P[j] where L <= j <= K-1
    TargetVal = array:get(K, PrefixXor),

    % Fenwick tree stores P[j] at Fenwick index j+1.
    % We need P[j] for j in [L, K-1].
    % This corresponds to Fenwick indices [L+1, K].

    % Roots to add for prefix sum up to K (inclusive)
    AddRoots = get_fenwick_roots(K, FenwickSize),
    % Roots to subtract for prefix sum up to L (exclusive)
    SubRoots = get_fenwick_roots(L, FenwickSize),

    MaxXorScore = query_trie_combined(AddRoots, SubRoots, TargetVal, M, ?MAX_BITS, TrieNodeCounter),

    NewResults = array:set(OriginalIdx, MaxXorScore, Results),
    process_queries_at_R(T, K, PrefixXor, M, NewResults, TrieNodeCounter, FenwickSize).

fenwick_update_loop(FenwickIdx, Val, OriginalIdx, TrieNodeCounter, FenwickSize) ->
    if FenwickIdx > FenwickSize ->
        {TrieNodeCounter, FenwickIdx};
    else
        RootId = case ets:lookup(?FENWICK_ROOTS_TABLE, FenwickIdx) of
                    [] -> 0;
                    [{_, R}] -> R
                 end,
        {NewTrieNodeCounter, NewRootId} = update_trie_add(RootId, Val, OriginalIdx, ?MAX_BITS, TrieNodeCounter),
        ets:insert(?FENWICK_ROOTS_TABLE, {FenwickIdx, NewRootId}),
        fenwick_update_loop(FenwickIdx + (FenwickIdx band -FenwickIdx), Val, OriginalIdx, NewTrieNodeCounter, FenwickSize)
    end.

fenwick_update(FenwickIdx, Val, OriginalIdx, TrieNodeCounter, FenwickSize) ->
    fenwick_update_loop(FenwickIdx, Val, OriginalIdx, TrieNodeCounter, FenwickSize).

update_trie_add(RootId, Val, _OriginalIdx, Bit, TrieNodeCounter) ->
    {CurrentTrieNodeCounter, CurrentRootId} = 
        if RootId == 0 ->
            NewTrieNodeCounter = TrieNodeCounter + 1,
            ets:insert(?TRIE_NODES_TABLE, {NewTrieNodeCounter, #trie_node{}}),
            {NewTrieNodeCounter, NewTrieNodeCounter};
        else
            {TrieNodeCounter, RootId}
        end,

    Node = case ets:lookup(?TRIE_NODES_TABLE, CurrentRootId) of
               [] -> #trie_node{};
               [{_, R}] -> R
           end,

    ets:insert(?TRIE_NODES_TABLE, {CurrentRootId, Node#trie_node{count = Node.count + 1}}),

    if Bit < 0 ->
        {CurrentTrieNodeCounter, CurrentRootId};
    else
        ValBit = (Val bsr Bit) band 1,
        ChildId = if ValBit == 0 -> Node.child0; else -> Node.child1 end,

        {NextTrieNodeCounter, NewChildId} = update_trie_add(ChildId, Val, _OriginalIdx, Bit - 1, CurrentTrieNodeCounter),

        UpdatedNode = case ets:lookup(?TRIE_NODES_TABLE, CurrentRootId) of
                          [{_, R}] -> R
                      end,
        FinalNode = if ValBit == 0 -> UpdatedNode#trie_node{child0 = NewChildId};
                    else -> UpdatedNode#trie_node{child1 = NewChildId} end,
        ets:insert(?TRIE_NODES_TABLE, {CurrentRootId, FinalNode}),

        {NextTrieNodeCounter, CurrentRootId}
    end.

get_fenwick_roots(FenwickIdx, _FenwickSize) ->
    get_fenwick_roots_loop(FenwickIdx, []).

get_fenwick_roots_loop(0, Acc) -> Acc;
get_fenwick_roots_loop(FenwickIdx, Acc) ->
    RootId = case ets:lookup(?FENWICK_ROOTS_TABLE, FenwickIdx) of
                [] -> 0;
                [{_, R}] -> R
             end,
    get_fenwick_roots_loop(FenwickIdx - (FenwickIdx band -FenwickIdx), [RootId | Acc]).

query_trie_combined(AddRoots, SubRoots, TargetVal, Limit, Bit, _TrieNodeCounter) ->
    if Bit < 0 ->
        0;
    else
        TargetValBit = (TargetVal bsr Bit) band 1,
        LimitBit = (Limit bsr Bit) band 1,

        % Option 1: Try to make current XOR bit 1 (by picking child 1 - TargetValBit)
        Count1MinusTargetValBit = get_combined_child_count(AddRoots, SubRoots, 1 - TargetValBit),

        NewAns1 = 
            if Count1MinusTargetValBit > 0 and LimitBit == 1 ->
                NextAddRoots1 = get_next_child_roots(AddRoots, 1 - TargetValBit),
                NextSubRoots1 = get_next_child_roots(SubRoots, 1 - TargetValBit),
                Res = query_trie_combined(NextAddRoots1, NextSubRoots1, TargetVal, Limit band ((1 bsl Bit) - 1), Bit - 1, _TrieNodeCounter),
                if Res /= -1 -> (1 bsl Bit) + Res; else -> -1 end;
            else
                -1
            end,

        % Option 2: Try to make current XOR bit 0 (by picking child TargetValBit)
        CountTargetValBit = get_combined_child_count(AddRoots, SubRoots, TargetValBit),

        NewAns2 = 
            if CountTargetValBit > 0 ->
                NextAddRoots0 = get_next_child_roots(AddRoots, TargetValBit),
                NextSubRoots0 = get_next_child_roots(SubRoots, TargetValBit),
                Res = query_trie_combined(NextAddRoots0, NextSubRoots0, TargetVal, Limit, Bit - 1, _TrieNodeCounter),
                if Res /= -1 -> Res; else -> -1 end;
            else
                -1
            end,

        max(NewAns1, NewAns2)
    end.

get_combined_child_count(AddRoots, SubRoots, ChildBit) ->
    AddCount = lists:foldl(fun(RootId, Acc) ->
        if RootId == 0 -> Acc;
        else
            Node = case ets:lookup(?TRIE_NODES_TABLE, RootId) of
                       [] -> #trie_node{};
                       [{_, R}] -> R
                   end,
            ChildId = if ChildBit == 0 -> Node.child0; else -> Node.child1 end,
            if ChildId == 0 -> Acc;
            else
                ChildNode = case ets:lookup(?TRIE_NODES_TABLE, ChildId) of
                                [] -> #trie_node{};
                                [{_, R}] -> R
                            end,
                Acc + ChildNode.count
            end
        end
    end, 0, AddRoots),

    SubCount = lists:foldl(fun(RootId, Acc) ->
        if RootId == 0 -> Acc;
        else
            Node = case ets:lookup(?TRIE_NODES_TABLE, RootId) of
                       [] -> #trie_node{};
                       [{_, R}] -> R
                   end,
            ChildId = if ChildBit == 0 -> Node.child0; else -> Node.child1 end,
            if ChildId == 0 -> Acc;
            else
                ChildNode = case ets:lookup(?TRIE_NODES_TABLE, ChildId) of
                                [] -> #trie_node{};
                                [{_, R}] -> R
                            end,
                Acc + ChildNode.count
            end
        end
    end, 0, SubRoots),

    AddCount - SubCount.

get_next_child_roots(Roots, ChildBit) ->
    lists:map(fun(RootId) ->
        if RootId == 0 -> 0;
        else
            Node = case ets:lookup(?TRIE_NODES_TABLE, RootId) of
                       [] -> #trie_node{};
                       [{_, R}] -> R
                   end,
            if ChildBit == 0 -> Node.child0; else -> Node.child1 end
        end
    end, Roots).