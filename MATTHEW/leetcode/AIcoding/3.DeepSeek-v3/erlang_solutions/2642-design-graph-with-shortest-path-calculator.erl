-module(graph).
-export([new/1, add_edge/4, shortest_path/3]).

new(N) ->
    {N, []}.

add_edge(N, Edges, From, To, Cost) when From >= 1, From =< N, To >= 1, To =< N ->
    {N, [{From, To, Cost} | Edges]}.

shortest_path(N, Edges, Node1, Node2) when Node1 >= 1, Node1 =< N, Node2 >= 1, Node2 =< N ->
    case Node1 of
        Node2 -> 0;
        _ ->
            Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, N)]),
            UpdatedDist = maps:put(Node1, 0, Dist),
            Q = [{0, Node1}],
            shortest_path_loop(Q, UpdatedDist, Edges, Node2)
    end.

shortest_path_loop([], _, _, _) ->
    -1;
shortest_path_loop([{DistU, U} | RestQ], Dist, Edges, Target) ->
    case U of
        Target -> DistU;
        _ ->
            {NewQ, NewDist} = process_edges(U, DistU, Edges, Dist, RestQ),
            shortest_path_loop(NewQ, NewDist, Edges, Target)
    end.

process_edges(U, DistU, Edges, Dist, Q) ->
    RelevantEdges = [E || {From, _, _} = E <- Edges, From =:= U],
    lists:foldl(
        fun({_, V, Cost}, {AccQ, AccDist}) ->
            case maps:get(V, AccDist) > DistU + Cost of
                true ->
                    NewDist = maps:put(V, DistU + Cost, AccDist),
                    NewQ = insert_sorted({DistU + Cost, V}, AccQ),
                    {NewQ, NewDist};
                false ->
                    {AccQ, AccDist}
            end
        end,
        {Q, Dist},
        RelevantEdges
    ).

insert_sorted(Item, []) ->
    [Item];
insert_sorted({Dist, _} = Item, [{HDist, _} = H | T]) when Dist < HDist ->
    [Item, H | T];
insert_sorted(Item, [H | T]) ->
    [H | insert_sorted(Item, T)].

infinity() ->
    16#3f3f3f3f.