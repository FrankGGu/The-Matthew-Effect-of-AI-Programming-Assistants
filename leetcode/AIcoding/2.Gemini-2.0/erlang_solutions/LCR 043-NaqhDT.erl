-module(complete_binary_tree_inserter).
-export([new/1, insert/1, insert/2, get_root/1]).

-record(state, {tree, count}).

new(Root) ->
    {Tree, Count} = build_tree(Root, 1),
    #state{tree = Tree, count = Count}.

insert(Val, State) ->
    insert(Val, State#state.tree, State#state.count).

insert(Val, Tree, Count) ->
    NextCount = Count + 1,
    ParentIndex = NextCount div 2,
    case proplists:get_value(ParentIndex, Tree) of
        undefined ->
            {Tree1, _} = build_tree({Val, null, null}, NextCount),
            NewTree = lists:merge(Tree, Tree1),
            {#state{tree = NewTree, count = NextCount}, proplists:get_value(1, Tree)};
        {PVal, L, R} ->
            case NextCount rem 2 of
                0 ->
                    {Tree1, _} = build_tree({PVal, {Val, null, null}, R}, ParentIndex),
                    NewTree = lists:merge(Tree, Tree1),
                     {#state{tree = NewTree, count = NextCount}, proplists:get_value(1, NewTree)};
                1 ->
                   {Tree1, _} = build_tree({PVal, L, {Val, null, null}}, ParentIndex),
                   NewTree = lists:merge(Tree, Tree1),
                   {#state{tree = NewTree, count = NextCount}, proplists:get_value(1, NewTree)}
            end
    end.

get_root(State) ->
    proplists:get_value(1, State#state.tree).

build_tree(null, _) ->
    {[], 0};
build_tree({Val, Left, Right}, Index) ->
    {LeftTree, LeftCount} = build_tree(Left, 2 * Index),
    {RightTree, RightCount} = build_tree(Right, 2 * Index + 1),
    Tree = [{Index, {Val, get_val(LeftTree, 2*Index), get_val(RightTree, 2*Index+1)}} | LeftTree ++ RightTree],
    {Tree, max([Index, LeftCount, RightCount])}.

get_val(Tree, Index) ->
    case proplists:get_value(Index, Tree) of
        {Val, _, _} ->
            Val;
        undefined ->
            null
    end.