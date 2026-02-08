-spec closest_nodes(Root :: #tree_node{} | null, Queries :: [integer()]) -> [[integer()]].
closest_nodes(Root, Queries) ->
    InOrder = in_order(Root, []),
    lists:map(fun(Q) -> find_closest(InOrder, Q) end, Queries).

in_order(null, Acc) -> Acc;
in_order(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    Acc1 = in_order(Left, Acc),
    Acc2 = [Val | in_order(Right, Acc1)],
    lists:reverse(Acc2).

find_closest(List, Q) ->
    case lists:member(Q, List) of
        true -> [Q, Q];
        false ->
            case List of
                [] -> [-1, -1];
                _ ->
                    Lower = find_lower(List, Q),
                    Higher = find_higher(List, Q),
                    [Lower, Higher]
            end
    end.

find_lower(List, Q) ->
    case lists:dropwhile(fun(X) -> X < Q end, List) of
        [] -> lists:last(List);
        [H | _] when H > Q ->
            case lists:takewhile(fun(X) -> X < Q end, List) of
                [] -> -1;
                L -> lists:last(L)
            end;
        _ -> -1
    end.

find_higher(List, Q) ->
    case lists:dropwhile(fun(X) -> X =< Q end, List) of
        [] -> -1;
        [H | _] -> H
    end.