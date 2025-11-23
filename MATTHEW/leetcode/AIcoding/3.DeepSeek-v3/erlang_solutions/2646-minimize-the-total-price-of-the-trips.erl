-module(solution).
-export([minimum_total_price/3]).

minimum_total_price(N, Edges, Price, Trips) ->
    Adj = build_adjacency(N, Edges),
    Count = count_visits(N, Adj, Trips),
    {Min1, Min2} = dfs(0, -1, Adj, Price, Count),
    min(Min1, Min2).

build_adjacency(N, Edges) ->
    Adj = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = update_adj(U, V, Acc),
                    update_adj(V, U, Acc1)
                end, Adj, Edges).

update_adj(U, V, Adj) ->
    List = lists:nth(U + 1, Adj),
    lists:sublist(Adj, U) ++ [[V | List]] ++ lists:nthtail(U + 1, Adj).

count_visits(N, Adj, Trips) ->
    Count = array:new(N, {default, 0}),
    lists:foldl(fun([Start, End], Acc) ->
                    Path = find_path(Start, End, Adj),
                    lists:foldl(fun(Node, Cnt) ->
                                    array:set(Node, array:get(Node, Cnt) + 1, Cnt)
                                end, Acc, Path)
                end, Count, Trips).

find_path(Start, End, Adj) ->
    {Path, _} = find_path_dfs(Start, -1, End, Adj),
    Path.

find_path_dfs(Node, Parent, End, Adj) ->
    if
        Node =:= End -> {[Node], true};
        true ->
            Neighbors = lists:nth(Node + 1, Adj),
            lists:foldl(fun(Neighbor, {CurrentPath, Found}) ->
                            if
                                Neighbor =/= Parent andalso not Found ->
                                    {Path, NewFound} = find_path_dfs(Neighbor, Node, End, Adj),
                                    if
                                        NewFound -> {[Node | Path], true};
                                        true -> {CurrentPath, false}
                                    end;
                                true -> {CurrentPath, Found}
                            end
                        end, {[], false}, Neighbors)
    end.

dfs(Node, Parent, Adj, Price, Count) ->
    Neighbors = lists:nth(Node + 1, Adj),
    FullPrice = Price[Node + 1] * array:get(Node, Count),
    HalfPrice = FullPrice div 2,
    {SumFull, SumHalf} = lists:foldl(fun(Neighbor, {Full, Half}) ->
                                        if
                                            Neighbor =/= Parent ->
                                                {ChildFull, ChildHalf} = dfs(Neighbor, Node, Adj, Price, Count),
                                                {Full + min(ChildFull, ChildHalf), Half + ChildFull};
                                            true -> {Full, Half}
                                        end
                                     end, {0, 0}, Neighbors),
    {FullPrice + SumFull, HalfPrice + SumHalf}.