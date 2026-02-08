-module(solution).
-export([reverse_between/3]).

traverse_to_pos(Current, 0) -> Current;
traverse_to_pos({_, Next}, Pos) -> traverse_to_pos(Next, Pos - 1).

reverse_n_nodes(Current, 0, Prev) -> {Prev, Current};
reverse_n_nodes(nil, _, Prev) -> {Prev, nil};
reverse_n_nodes({Val, Next}, N, Prev) ->
    reverse_n_nodes(Next, N - 1, {Val, Prev}).

append_to_tail(Node, Suffix) ->
    case element(2, Node) of
        nil -> {element(1, Node), Suffix};
        Next -> {element(1, Node), append_to_tail(Next, Suffix)}
    end.

reconstruct_from_dummy(Current, TargetNode, OriginalNode) ->
    if
        Current == OriginalNode -> TargetNode;
        true ->
            {Val, Next} = Current,
            {Val, reconstruct_from_dummy(Next, TargetNode, OriginalNode)}
    end.

reverse_between(Head, Left, Right) ->
    if
        Left == Right -> Head;
        Head == nil -> nil;
        true ->
            Dummy = {0, Head},

            PreLeft = traverse_to_pos(Dummy, Left - 1),

            StartNode = element(2, PreLeft),

            {ReversedHead, NodeAfterReversedSegment} = reverse_n_nodes(StartNode, Right - Left + 1, nil),

            FinalReversedSegment = append_to_tail(ReversedHead, NodeAfterReversedSegment),

            NewPreLeft = {element(1, PreLeft), FinalReversedSegment},

            element(2, reconstruct_from_dummy(Dummy, NewPreLeft, PreLeft))
    end.