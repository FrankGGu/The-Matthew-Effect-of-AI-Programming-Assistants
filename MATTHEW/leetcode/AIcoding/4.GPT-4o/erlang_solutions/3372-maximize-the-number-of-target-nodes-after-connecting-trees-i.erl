-module(solution).
-export([max_target_nodes/2]).

-record(node, {id, targets=[]}).

max_target_nodes(Trees, Edges) ->
    TreesList = lists:map(fun(Id) -> #node{id=Id} end, Trees),
    connect_edges(TreesList, Edges),
    lists:max(lists:map(fun(Node) -> count_targets(Node) end, TreesList)).

connect_edges(Trees, Edges) ->
    lists:foreach(fun({A, B}) ->
        Trees1 = lists:map(fun(Node) ->
            case Node#node.id of
                A -> Node#node{targets=[B | Node#node.targets]};
                B -> Node#node{targets=[A | Node#node.targets]};
                _ -> Node
            end
        end, Trees),
        Trees1
    end, Edges).

count_targets(Node) ->
    length(Node#node.targets).