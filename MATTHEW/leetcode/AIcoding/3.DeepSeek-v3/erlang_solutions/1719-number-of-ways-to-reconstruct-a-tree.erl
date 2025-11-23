-module(solution).
-export([check_ways/1]).

check_ways(Pairs) ->
    Adj = maps:new(),
    Degree = maps:new(),
    lists:foreach(fun([U, V]) ->
        Adj1 = maps:update_with(U, fun(Set) -> sets:add_element(V, Set) end, sets:from_list([V]), Adj),
        Adj2 = maps:update_with(V, fun(Set) -> sets:add_element(U, Set) end, sets:from_list([U]), Adj1),
        Degree1 = maps:update_with(U, fun(D) -> D + 1 end, 1, Degree),
        Degree2 = maps:update_with(V, fun(D) -> D + 1 end, 1, Degree1),
        Adj = Adj2,
        Degree = Degree2
    end, Pairs),
    Nodes = lists:sort(fun(A, B) ->
        case maps:get(A, Degree) == maps:get(B, Degree) of
            true -> A =< B;
            false -> maps:get(A, Degree) > maps:get(B, Degree)
        end
    end, maps:keys(Degree)),
    Root = hd(Nodes),
    case maps:get(Root, Degree) =/= length(Nodes) - 1 of
        true -> 0;
        false ->
            case check(Nodes, Adj, Degree, Root, sets:new(), maps:new()) of
                {true, 1} -> 1;
                {true, _} -> 2;
                _ -> 0
            end
    end.

check([], _, _, _, _, _) -> {true, 0};
check([Node | Rest], Adj, Degree, Parent, Visited, ParentMap) ->
    case sets:is_element(Node, Visited) of
        true -> {true, 0};
        false ->
            ParentSet = maps:get(Node, Adj),
            case sets:is_element(Parent, ParentSet) of
                false -> false;
                true ->
                    NewVisited = sets:add_element(Node, Visited),
                    NewParentMap = maps:put(Node, Parent, ParentMap),
                    case check_children(Rest, Adj, Degree, Node, NewVisited, NewParentMap) of
                        false -> false;
                        {true, Cnt} ->
                            case check(Rest, Adj, Degree, Parent, NewVisited, NewParentMap) of
                                false -> false;
                                {true, Cnt2} -> {true, Cnt + Cnt2}
                            end
                    end
            end
    end.

check_children([], _, _, _, _, _) -> {true, 0};
check_children([Child | Rest], Adj, Degree, Parent, Visited, ParentMap) ->
    ChildSet = maps:get(Child, Adj),
    ParentSet = maps:get(Parent, Adj),
    case sets:is_subset(ChildSet, ParentSet) of
        false -> false;
        true ->
            case check([Child | Rest], Adj, Degree, Parent, Visited, ParentMap) of
                false -> false;
                {true, Cnt} ->
                    case maps:get(Child, Degree) == maps:get(Parent, Degree) of
                        true -> {true, Cnt + 1};
                        false -> {true, Cnt}
                    end
            end
    end.