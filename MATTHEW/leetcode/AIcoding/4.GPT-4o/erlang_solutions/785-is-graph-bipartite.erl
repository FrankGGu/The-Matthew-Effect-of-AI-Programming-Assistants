-module(solution).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    N = length(Graph),
    Color = lists:duplicate(N, -1),
    lists:foldl(fun(Node, Acc) -> 
        case Acc of
            {ok, Color} -> 
                if Color(Node) =:= -1 -> 
                    case dfs(Node, 0, Color, Graph) of
                        {ok, NewColor} -> {ok, NewColor};
                        _ -> {error}
                    end;
                true -> Acc
                end;
            Error -> Error
        end
    end, {ok, Color}, lists:seq(0, N - 1)) =:= {ok, _}.

dfs(Node, C, Color, Graph) ->
    case lists:nth(Node + 1, Color) of
        -1 ->
            NewColor = lists:replace(Node + 1, C, Color),
            Neighbors = lists:nth(Node + 1, Graph),
            lists:foldl(fun(Neighbor, Acc) ->
                case Acc of
                    {ok, Color} -> 
                        NewC = if C =:= 0 -> 1; true -> 0 end,
                        dfs(Neighbor, NewC, Color, Graph);
                    Error -> Error
                end
            end, {ok, NewColor}, Neighbors);
        C -> {ok, Color};
        _ -> {error}
    end.