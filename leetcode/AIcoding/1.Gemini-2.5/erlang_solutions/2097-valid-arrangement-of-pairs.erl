-module(solution).
-export([validArrangement/1]).

validArrangement(Pairs) ->
    {Graph, InDegree, OutDegree} = build_graph(Pairs),
    StartNode = find_start_node(InDegree, OutDegree),
    NodePath = hierholzer(StartNode, Graph),
    convert_to_pairs(NodePath).

build_graph(Pairs) ->
    Graph0 = #{},
    InDegree0 = #{},
    OutDegree0 = #{},
    AllNodes0 = sets:new(),

    {Graph1, InDegree1, OutDegree1, AllNodes1} = lists:foldl(
        fun([U, V], {AccGraph, AccIn, AccOut, AccNodes}) ->
            NewGraph = maps:update_with(U, fun(L) -> [V|L] end, [V], AccGraph),
            NewIn = maps:update_with(V, fun(C) -> C + 1 end, 1, AccIn),
            NewOut = maps:update_with(U, fun(C) -> C + 1 end, 1, AccOut),
            NewNodes = sets:add_element(U, sets:add_element(V, AccNodes)),
            {NewGraph, NewIn, NewOut, NewNodes}
        end,
        {Graph0, InDegree0, OutDegree0, AllNodes0},
        Pairs
    ),

    FinalInDegree = sets:fold(fun(Node, Acc) -> maps:put_new(Node, 0, Acc) end, InDegree1, AllNodes1),
    FinalOutDegree = sets:fold(fun(Node, Acc) -> maps:put_new(Node, 0, Acc) end, OutDegree1, AllNodes1),

    {Graph1, FinalInDegree, FinalOutDegree}.

find_start_node(InDegree, OutDegree) ->
    NodeList = maps:keys(InDegree) ++ maps:keys(OutDegree),
    UniqueNodes = lists:usort(NodeList), 

    DefaultStart = case maps:keys(OutDegree) of
                       [] -> 0;
                       [H|_] -> H
                   end,

    lists:foldl(
        fun(Node, CurrentStart) ->
            In = maps:get(Node, InDegree, 0),
            Out = maps:get(Node, OutDegree, 0),
            case Out - In of
                1 -> Node;
                _ -> CurrentStart
            end
        end,
        DefaultStart,
        UniqueNodes
    ).

hierholzer(StartNode, Graph) ->
    hierholzer_loop([StartNode], Graph, []).

hierholzer_loop([], _CurrentGraph, Path) ->
    lists:reverse(Path);
hierholzer_loop([U | T_Stack] = Stack, CurrentGraph, Path) ->
    case maps:get(U, CurrentGraph, []) of
        [] ->
            hierholzer_loop(T_Stack, CurrentGraph, [U | Path]);
        [V | T_Neighbors] ->
            NewGraph = maps:update(U, T_Neighbors, CurrentGraph),
            hierholzer_loop([V | Stack], NewGraph, Path)
    end.

convert_to_pairs(NodePath) ->
    convert_to_pairs_recursive(NodePath, []).

convert_to_pairs_recursive([_], Acc) ->
    lists:reverse(Acc);
convert_to_pairs_recursive([N1, N2 | T], Acc) ->
    convert_to_pairs_recursive([N2 | T], [[N1, N2] | Acc]).