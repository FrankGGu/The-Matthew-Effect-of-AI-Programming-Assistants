-module(Solution).
-export([new/0, add_edge/3, shortest_path/3]).

-record(graph, {adj = dict:new()}).

new() ->
    #graph{}.

add_edge(Graph, From, To, Weight) ->
    NewAdj = dict:update(From, [{To, Weight}], 
                fun(Edges) -> [{To, Weight} | Edges] end, Graph#graph.adj),
    Graph#graph{adj = NewAdj}.

shortest_path(Graph, Start, End) ->
    D = dict:from_list([{Start, 0}]),
    Visited = dict:new(),
    shortest_path_helper(Graph, Start, End, D, Visited).

shortest_path_helper(Graph, Current, End, Dist, Visited) ->
    case dict:find(Current, Visited) of
        error ->
            NewVisited = dict:store(Current, true, Visited),
            case dict:find(Current, Dist) of
                {ok, Cost} ->
                    case dict:find(Current, Graph#graph.adj) of
                        error -> 
                            if Current =:= End -> Cost; true -> infinity end;
                        {ok, Edges} ->
                            lists:foldl(fun({Next, Weight}, Acc) ->
                                NewDist = dict:update(Next, Cost + Weight, 
                                    fun(C) -> min(C, Cost + Weight) end, Dist),
                                shortest_path_helper(Graph, Next, End, NewDist, NewVisited)
                            end, infinity, Edges)
                    end;
                error -> infinity
            end;
        _ -> infinity
    end.