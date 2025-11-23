-module(solution).
-export([buildTree/2]).

buildTree(Inorder, Postorder) ->
    InMap = build_inorder_map(Inorder),
    TuplePostorder = list_to_tuple(Postorder),
    buildTree_recursive(Inorder, TuplePostorder, 0, length(Inorder) - 1, 0, length(Postorder) - 1, InMap).

build_inorder_map(List) ->
    build_inorder_map(List, 0, #{}).

build_inorder_map([], _Idx, Map) -> Map;
build_inorder_map([H|T], Idx, Map) ->
    build_inorder_map(T, Idx + 1, maps:put(H, Idx, Map)).

buildTree_recursive(_Inorder, _TuplePostorder, InStart, InEnd, _PostStart, _PostEnd, _InMap) when InStart > InEnd ->
    nil;
buildTree_recursive(Inorder, TuplePostorder, InStart, InEnd, PostStart, PostEnd, InMap) ->
    RootVal = element(PostEnd + 1, TuplePostorder),

    RootIdx = maps:get(RootVal, InMap),

    NumLeft = RootIdx - InStart,

    LeftTree = buildTree_recursive(Inorder, TuplePostorder, InStart, RootIdx - 1, PostStart, PostStart + NumLeft - 1, InMap),
    RightTree = buildTree_recursive(Inorder, TuplePostorder, RootIdx + 1, InEnd, PostStart + NumLeft, PostEnd - 1, InMap),

    {RootVal, LeftTree, RightTree}.