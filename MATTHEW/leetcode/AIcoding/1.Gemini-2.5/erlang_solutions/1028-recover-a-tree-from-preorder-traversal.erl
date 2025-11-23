-module(solution).
-export([recoverFromPreorder/1]).

-record(treenode, {val, left = nil, right = nil}).

recoverFromPreorder(S) ->
    Segments = parse_string(S),
    build_tree(Segments).

parse_string(S) ->
    Matches = re:run(S, "(-*)(\\d+)", [{capture, all_as_string}, global]),
    case Matches of
        {match, L} ->
            lists:map(fun([_, Dashes, NumStr]) ->
                              {string:len(Dashes), list_to_integer(NumStr)}
                      end, L);
        nomatch ->
            []
    end.

build_tree([{0, Val} | RestSegments]) ->
    Root = #treenode{val = Val},
    build_tree_acc(RestSegments, [{Root, 0}]);
build_tree([]) ->
    nil.

build_tree_acc([], [{Root, _Depth}]) ->
    Root;
build_tree_acc([{CurrentDepth, CurrentVal} | RestSegments], Stack) ->
    NewNode = #treenode{val = CurrentVal},

    {PoppedStack, {ParentNode, ParentDepth}} = pop_stack_until_parent(Stack, CurrentDepth),

    UpdatedParentNode =
        case ParentNode#treenode.left of
            nil -> ParentNode#treenode{left = NewNode};
            _ -> ParentNode#treenode{right = NewNode}
        end,

    NewStack = [{UpdatedParentNode, ParentDepth} | PoppedStack],

    FinalStack = [{NewNode, CurrentDepth} | NewStack],

    build_tree_acc(RestSegments, FinalStack).

pop_stack_until_parent(Stack, CurrentDepth) ->
    pop_stack_until_parent_acc(Stack, CurrentDepth).

pop_stack_until_parent_acc([{_N, D} | T], CurrentDepth) when D >= CurrentDepth ->
    pop_stack_until_parent_acc(T, CurrentDepth);
pop_stack_until_parent_acc([ParentTuple | T], _CurrentDepth) ->
    {T, ParentTuple};
pop_stack_until_parent_acc([], _CurrentDepth) ->
    {[], nil}.