-module(solution).
-export([findCheapestPrice/5]).

findCheapestPrice(N, Flights, src, dst, K) ->
    Edges = lists:foldl(fun({From, To, Price}, Acc) ->
        maps:update_with(From, fun(L) -> [{To, Price} | L] end, fun() -> [{To, Price}] end, Acc)
    end, maps:new(), Flights),
    bfs([{src, 0, 0}], dst, K, Edges, infinity).

bfs([], _, _, _, MinCost) -> 
    if MinCost =:= infinity -> -1; true -> MinCost end;
bfs([{Node, Cost, Stops} | Rest], Dst, K, Edges, MinCost) ->
    if Node =:= Dst -> 
        bfs(Rest, Dst, K, Edges, min(Cost, MinCost));
    Stops =< K ->
        Next = maps:get(Node, Edges, []),
        NewRest = lists:foldl(fun({NextNode, Price}, Acc) ->
            [{NextNode, Cost + Price, Stops + 1} | Acc]
        end, Rest, Next),
        bfs(NewRest, Dst, K, Edges, MinCost);
    true -> 
        bfs(Rest, Dst, K, Edges, MinCost)
    end.