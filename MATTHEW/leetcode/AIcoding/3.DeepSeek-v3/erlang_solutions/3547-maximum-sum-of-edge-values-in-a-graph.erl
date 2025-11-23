-module(solution).
-export([maximum_sum/1]).

maximum_sum(Edges) ->
    Parent = maps:new(),
    {Sum, _} = lists:foldl(fun([U, V, W], {Acc, P}) ->
        RootU = find(U, P),
        RootV = find(V, P),
        case RootU =/= RootV of
            true ->
                NewP = maps:put(RootV, RootU, P),
                {Acc + W, NewP};
            false ->
                {Acc, P}
        end
    end, {0, Parent}, Edges),
    Sum.

find(Node, Parent) ->
    case maps:get(Node, Parent, Node) of
        Node -> Node;
        P ->
            Root = find(P, Parent),
            maps:put(Node, Root, Parent),
            Root
    end.