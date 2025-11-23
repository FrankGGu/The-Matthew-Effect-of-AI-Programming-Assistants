-module(solution).
-export([block_placement_queries/2]).

-record(seg_node, {max_prefix_free = 0, max_suffix_free = 0, max_free = 0, is_full = false, len = 0}).

block_placement_queries(Blocks, Queries) ->
    SortedUniqueCoords = collect_coords(Blocks, Queries),
    CoordsTuple = list_to_tuple(SortedUniqueCoords),

    NumLeaves = length(SortedUniqueCoords) - 1,

    InitialTree = maps:new(),
    Tree0 = build_tree(CoordsTuple, 1, NumLeaves, 1, InitialTree),

    Tree1 = lists:foldl(fun(Block, CurrentTree) ->
        [P, S] = Block,
        BlockStart = P - S + 1,
        BlockEnd = P,

        L_comp = binary_search_lower_bound(CoordsTuple, BlockStart, 1, length(CoordsTuple)),
        R_comp = binary_search_upper_bound(CoordsTuple, BlockEnd, 1, length(CoordsTuple)) - 1,

        if L_comp > R_comp ->
            CurrentTree;
        true ->
            update_tree(CurrentTree, CoordsTuple, 1, NumLeaves, 1, L_comp, R_comp)
        end
    end, Tree0, Blocks),

    lists:map(fun(Query) ->
        [P, S] = Query,

        QueryEndCompressedIdx = binary_search_upper_bound(CoordsTuple, P, 1, length(CoordsTuple)) - 1,

        if QueryEndCompressedIdx < 1 ->
            false;
        true ->
            ResultNode = query_tree(Tree1, CoordsTuple, 1, NumLeaves, 1, 1, QueryEndCompressedIdx),
            ResultNode#seg_node.max_free >= S
        end
    end, Queries).

init_leaf_node(Coords, Idx) ->
    Len = element(Idx + 2, Coords) - element(Idx + 1, Coords),
    #seg_node{max_prefix_free = Len, max_suffix_free = Len, max_free = Len, is_full = false, len = Len}.

full_node(Len) ->
    #seg_node{max_prefix_free = 0, max_suffix_free = 0, max_free = 0, is_full = true, len = Len}.

merge_nodes(LeftNode, RightNode) ->
    Len = LeftNode#seg_node.len + RightNode#seg_node.len,
    IsFull = LeftNode#seg_node.is_full and RightNode#seg_node.is_full,
    MaxPrefixFree = 
        case LeftNode#seg_node.is_full of
            true -> 0;
            false ->
                case LeftNode#seg_node.max_prefix_free == LeftNode#seg_node.len of
                    true -> LeftNode#seg_node.len + RightNode#seg_node.max_prefix_free;
                    false -> LeftNode#seg_node.max_prefix_free
                end
        end,
    MaxSuffixFree =
        case RightNode#seg_node.is_full of
            true -> 0;
            false ->
                case RightNode#seg_node.max_suffix_free == RightNode#seg_node.len of
                    true -> RightNode#seg_node.len + LeftNode#seg_node.max_suffix_free;
                    false -> RightNode#seg_node.max_suffix_free
                end
        end,
    MaxFree = max(LeftNode#seg_node.max_free, RightNode#seg_node.max_free, 
                  LeftNode#seg_node.max_suffix_free + RightNode#seg_node.max_prefix_free),
    #seg_node{max_prefix_free = MaxPrefixFree, max_suffix_free = MaxSuffixFree, 
              max_free = MaxFree, is_full = IsFull, len = Len}.

build_tree(Coords, LowIdx, HighIdx, NodeIdx, Tree) ->
    if LowIdx == HighIdx ->
        Node = init_leaf_node(Coords, LowIdx),
        maps:put(NodeIdx, Node, Tree);
    true ->
        MidIdx = LowIdx + (HighIdx - LowIdx) div 2,
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        Tree1 = build_tree(Coords, LowIdx, MidIdx, LeftChildIdx, Tree),
        Tree2 = build_tree(Coords, MidIdx + 1, HighIdx, RightChildIdx, Tree1),

        LeftNode = maps:get(LeftChildIdx, Tree2),
        RightNode = maps:get(RightChildIdx, Tree2),
        ParentNode = merge_nodes(LeftNode, RightNode),
        maps:put(NodeIdx, ParentNode, Tree2)
    end.

push_down(Tree, NodeIdx, Coords, LowIdx, HighIdx) ->
    Node = maps:get(NodeIdx, Tree),
    if Node#seg_node.is_full andalso LowIdx /= HighIdx ->
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        MidIdx = LowIdx + (HighIdx - LowIdx) div 2,
        LeftLen = element(MidIdx + 2, Coords) - element(LowIdx + 1, Coords),
        RightLen = element(HighIdx + 2, Coords) - element(MidIdx + 1, Coords),

        Tree1 = maps:put(LeftChildIdx, full_node(LeftLen), Tree),
        Tree2 = maps:put(RightChildIdx, full_node(RightLen), Tree1),

        maps:put(NodeIdx, Node#seg_node{is_full = false}, Tree2);
    true ->
        Tree
    end.

update_tree(Tree, Coords, LowIdx, HighIdx, NodeIdx, UpdateL, UpdateR) ->
    Node = maps:get(NodeIdx, Tree),

    if UpdateL > HighIdx or UpdateR < LowIdx ->
        Tree;
    true when UpdateL <= LowIdx andalso HighIdx <= UpdateR ->
        maps:put(NodeIdx, full_node(Node#seg_node.len), Tree);
    true ->
        Tree1 = push_down(Tree, NodeIdx, Coords, LowIdx, HighIdx),

        MidIdx = LowIdx + (HighIdx - LowIdx) div 2,
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        Tree2 = update_tree(Tree1, Coords, LowIdx, MidIdx, LeftChildIdx, UpdateL, UpdateR),
        Tree3 = update_tree(Tree2, Coords, MidIdx + 1, HighIdx, RightChildIdx, UpdateL, UpdateR),

        LeftNode = maps:get(LeftChildIdx, Tree3),
        RightNode = maps:get(RightChildIdx, Tree3),
        ParentNode = merge_nodes(LeftNode, RightNode),
        maps:put(NodeIdx, ParentNode, Tree3)
    end.

query_tree(Tree, Coords, LowIdx, HighIdx, NodeIdx, QueryL, QueryR) ->
    Node = maps:get(NodeIdx, Tree),

    if QueryL > HighIdx or QueryR < LowIdx ->
        full_node(0);
    true when QueryL <= LowIdx andalso HighIdx <= QueryR ->
        Node;
    true ->
        Tree1 = push_down(Tree, NodeIdx, Coords, LowIdx, HighIdx),

        MidIdx = LowIdx + (HighIdx - LowIdx) div 2,
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        LeftResult = query_tree(Tree1, Coords, LowIdx, MidIdx, LeftChildIdx, QueryL, QueryR),
        RightResult = query_tree(Tree1, Coords, MidIdx + 1, HighIdx, RightChildIdx, QueryL, QueryR),

        merge_nodes(LeftResult, RightResult)
    end.

binary_search_lower_bound(Tuple, Val, Low, High) ->
    if Low > High -> Low;
    true ->
        Mid = Low + (High - Low) div 2,
        MidVal = element(Mid, Tuple),
        if MidVal >= Val ->
            binary_search_lower_bound(Tuple, Val, Low, Mid - 1);
        true ->
            binary_search_lower_bound(Tuple, Val, Mid + 1, High)
        end
    end.

binary_search_upper_bound(Tuple, Val, Low, High) ->
    if Low > High -> Low;
    true ->
        Mid = Low + (High - Low) div 2,
        MidVal = element(Mid, Tuple),
        if MidVal > Val ->
            binary_search_upper_bound(Tuple, Val, Low, Mid - 1);
        true ->
            binary_search_upper_bound(Tuple, Val, Mid + 1, High)
        end
    end.

collect_coords(Blocks, Queries) ->
    BlockPoints = lists:flatmap(fun([P, S]) -> [P - S + 1, P] end, Blocks),
    QueryPoints = lists:map(fun([P, _S]) -> P end, Queries),

    RelevantPoints = BlockPoints ++ QueryPoints,

    MaxVal = lists:foldl(fun(C, Acc) -> max(Acc, C) end, 0, RelevantPoints),

    lists:usort([1] ++ RelevantPoints ++ [MaxVal + 1]).