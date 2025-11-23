-module(solution).
-export([vertical_traversal/1]).

-record('TreeNode', {val, left, right}).

vertical_traversal(Root) ->
    Tuples = collect_nodes(Root, 0, 0, []),
    SortedTuples = lists:sort(fun({C1, R1, V1}, {C2, R2, V2}) ->
                                  if C1 =/= C2 -> C1 < C2;
                                     R1 =/= R2 -> R1 < R2;
                                     true -> V1 < V2
                                  end
                              end, Tuples),
    group_and_extract(SortedTuples, []).

collect_nodes(nil, _, _, Acc) -> Acc;
collect_nodes(#'TreeNode'{val = Val, left = Left, right = Right}, Col, Row, Acc) ->
    Acc1 = collect_nodes(Left, Col - 1, Row + 1, Acc),
    Acc2 = collect_nodes(Right, Col + 1, Row + 1, Acc1),
    [{Col, Row, Val} | Acc2].

group_and_extract([], Acc) ->
    lists:reverse([lists:reverse(Group) || {_, Group} <- Acc]);
group_and_extract([{Col, _, Val} | T], []) ->
    group_and_extract(T, [{Col, [Val]}]);
group_and_extract([{Col, _, Val} | T], [{CurrentCol, CurrentGroup} | AccRest]) when Col == CurrentCol ->
    group_and_extract(T, [{CurrentCol, [Val | CurrentGroup]} | AccRest]);
group_and_extract([{Col, _, Val} | T], Acc) ->
    group_and_extract(T, [{Col, [Val]} | Acc]).