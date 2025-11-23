-module(solution).
-export([findTheCity/2]).

findTheCity(Cities, Threshold) ->
    N = Cities,
    Adj = lists:seq(0, N-1),
    Dist = init_dist(N),
    for_each(Adj, fun(I) -> dijkstra(Dist, I, Cities, Threshold) end),
    find_min_city(Dist, N, Threshold).

init_dist(N) ->
    lists:foldl(fun(I, Acc) -> 
        lists:foldl(fun(J, Acc2) -> 
            case I == J of
                true -> [0 | Acc2];
                false -> [infinity | Acc2]
            end
        end, [], lists:seq(0, N-1))
    end, [], lists:seq(0, N-1)).

dijkstra(Dist, Start, N, Threshold) ->
    Heap = {[], [{0, Start}]},
    Visited = sets:new(),
    D = dist_copy(Dist),
    {_, NewD} = dijkstra_helper(D, Heap, Visited, N, Threshold),
    NewD.

dijkstra_helper(D, Heap, Visited, N, Threshold) ->
    case Heap of
        {_, []} -> {Visited, D};
        _ ->
            {MinDist, Node} = erlang:hd(lists:reverse(Heap)),
            case MinDist > Threshold of
                true -> {Visited, D};
                false ->
                    NewHeap = remove_heap(Heap, Node),
                    Neighbors = get_neighbors(Node, N),
                    lists:foreach(fun({Neighbor, Weight}) ->
                        case MinDist + Weight < element(Neighbor+1, D) of
                            true ->
                                NewDist = setelement(Neighbor+1, D, MinDist + Weight),
                                NewHeap2 = add_heap(NewHeap, {MinDist + Weight, Neighbor}),
                                D = NewDist;
                            false -> ok
                        end
                    end, Neighbors),
                    dijkstra_helper(D, NewHeap, sets:add_element(Node, Visited), N, Threshold)
    end.

get_neighbors(Node, N) ->
    lists:foldl(fun(I, Acc) ->
        case I /= Node of
            true -> [{I, 1} | Acc];
            false -> Acc
        end
    end, [], lists:seq(0, N-1)).

remove_heap({List, Heap}, Node) ->
    {lists:filter(fun({_, X}) -> X /= Node end, List), Heap}.

add_heap({List, Heap}, {Dist, Node}) ->
    {lists:sort([{Dist, Node} | List]), Heap}.

dist_copy(Dist) ->
    lists:foldl(fun(I, Acc) -> [element(I+1, Dist) | Acc] end, [], lists:seq(0, length(Dist)-1)).

find_min_city(Dist, N, Threshold) ->
    Count = lists:map(fun(I) ->
        lists:foldl(fun(J, Acc) ->
            if element(J+1, Dist) =< Threshold -> Acc + 1;
               true -> Acc
            end
        end, 0, lists:seq(0, N-1))
    end, lists:seq(0, N-1)),
    find_min_index(Count, 0, 0, 0).

find_min_index([], _, MinIndex, _) -> MinIndex;
find_min_index([H | T], Index, MinIndex, MinCount) ->
    case H < MinCount of
        true -> find_min_index(T, Index+1, Index, H);
        false -> find_min_index(T, Index+1, MinIndex, MinCount)
    end.