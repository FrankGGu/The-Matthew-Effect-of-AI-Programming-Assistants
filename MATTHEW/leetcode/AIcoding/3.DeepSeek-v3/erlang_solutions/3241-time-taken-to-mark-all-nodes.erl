-module(solution).
-export([time_to_mark_all_nodes/2]).

time_to_mark_all_nodes(N, Edges) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                          dict:append(U, V, dict:append(V, U, Acc))
                      end, dict:new(), Edges),
    Q = queue:from_list([0]),
    Visited = sets:from_list([0]),
    time_to_mark_all_nodes_bfs(Q, Adj, Visited, 0).

time_to_mark_all_nodes_bfs(Q, Adj, Visited, Time) ->
    case queue:is_empty(Q) of
        true -> Time;
        false ->
            {Current, Q1} = queue:out(Q),
            Neighbors = case dict:find(Current, Adj) of
                          {ok, Ns} -> Ns;
                          error -> []
                        end,
            {NewQ, NewVisited} = lists:foldl(fun(N, {QAcc, VAcc}) ->
                                                case sets:is_element(N, VAcc) of
                                                    true -> {QAcc, VAcc};
                                                    false -> 
                                                        NewVAcc = sets:add_element(N, VAcc),
                                                        NewQAcc = queue:in(N, QAcc),
                                                        {NewQAcc, NewVAcc}
                                                end
                                            end, {Q1, Visited}, Neighbors),
            time_to_mark_all_nodes_bfs(NewQ, Adj, NewVisited, Time + 1)
    end.