-module(solution).
-export([CBTInserter/1]).

-record(node, {val, left = undefined, right = undefined}).

CBTInserter(Tree) ->
    Root = build_tree(Tree),
    {Root, []}.

build_tree([]) -> undefined;
build_tree([H|T]) ->
    Node = #node{val = H},
    {Node, build_tree(T)}.

insert(InsertVal, {Root, Queue}) ->
    case Queue of
        [] -> 
            {Root, [Root]};
        [H | T] ->
            if
                H#node.left =:= undefined ->
                    H#node.left = #node{val = InsertVal},
                    {Root, T};
                H#node.right =:= undefined ->
                    H#node.right = #node{val = InsertVal},
                    {Root, T};
                true ->
                    {Root, T ++ [H#node.left, H#node.right]}
            end
    end.

get_root({Root, _}) -> Root.