-module(solution).
-export([possible_bipartition/2]).

possible_bipartition(N, Dislikes) ->
    Adj = build_adj(Dislikes),
    Colors = maps:new(),
    possible_bipartition_loop(1, N, Adj, Colors).

possible_bipartition_loop(Node, N, Adj, Colors) when Node > N ->
    true;
possible_bipartition_loop(Node, N, Adj, Colors) ->
    case maps:is_key(Node, Colors) of
        true ->
            possible_bipartition_loop(Node + 1, N, Adj, Colors);
        false ->
            case dfs(Node, 1, Adj, Colors) of
                {true, NewColors} ->
                    possible_bipartition_loop(Node + 1, N, Adj, NewColors);
                {false, _} ->
                    false
            end
    end.

dfs(U, Color, Adj, Colors) ->
    NewColors = maps:put(U, Color, Colors),
    Neighbors = maps:get(U, Adj, []),
    dfs_neighbors(Neighbors, U, Color, Adj, NewColors).

dfs_neighbors([], _U, _Color, _Adj, Colors) ->
    {true, Colors};
dfs_neighbors([V|Rest], U, Color, Adj, Colors) ->
    case maps:is_key(V, Colors) of
        true ->
            case maps:get(V, Colors) of
                Color ->
                    {false, Colors};
                _OtherColor ->
                    dfs_neighbors(Rest, U, Color, Adj, Colors)
            end;
        false ->
            OppositeColor = 3 - Color,
            case dfs(V, OppositeColor, Adj, Colors) of
                {true, UpdatedColors} ->
                    dfs_neighbors(Rest, U, Color, Adj, UpdatedColors);
                {false, _} ->
                    {false, Colors}
            end
    end.

build_adj(Dislikes) ->
    lists:foldl(
        fun([A, B], Acc) ->
            Acc1 = maps:update_with(A, fun(L) -> [B|L] end, [], Acc),
            maps:update_with(B, fun(L) -> [A|L] end, [], Acc1)
        end,
        maps:new(),
        Dislikes
    ).