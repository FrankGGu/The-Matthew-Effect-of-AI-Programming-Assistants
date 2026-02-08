-module(solution).
-export([shortestAlternatingPaths/3]).

shortestAlternatingPaths(N, RedEdges, BlueEdges) ->
    Adj0 = maps:from_list([{I, #{red => [], blue => []}} || I <- lists:seq(0, N-1)]),

    Adj1 = lists:foldl(fun({U, V}, Acc) ->
                           maps:update_with(U, fun(M) -> maps:update_with(red, fun(L) -> [V | L] end, M) end, Acc)
                       end, Adj0, RedEdges),

    Adj = lists:foldl(fun({U, V}, Acc) ->
                          maps:update_with(U, fun(M) -> maps:update_with(blue, fun(L) -> [V | L] end, M) end, Acc)
                      end, Adj1, BlueEdges),

    Dist0 = array:new(N, {infinity, infinity}),
    Dist = array:set(0, {0, 0}, Dist0),

    Q0 = queue:new(),
    Q1 = queue:in({0, red, 0}, Q0),
    Q = queue:in({0, blue, 0}, Q1),

    bfs(Q, Adj, Dist, N).

bfs(Q, Adj, Dist, N) ->
    case queue:out(Q) of
        {{value, {U, LastColor, D}}, RestQ} ->
            NextColor = case LastColor of
                            red -> blue;
                            blue -> red
                        end,

            Neighbors = maps:get(NextColor, maps:get(U, Adj)),

            {NewDist, NewQ} = lists:foldl(
                fun(V, {CurrentDist, CurrentQ}) ->
                    {DistRedV, DistBlueV} = array:get(V, CurrentDist),

                    OldVDist = case NextColor of
                                   red -> DistRedV;
                                   blue -> DistBlueV
                               end,

                    if
                        D + 1 < OldVDist ->
                            UpdatedDistV = case NextColor of
                                               red -> {D + 1, DistBlueV};
                                               blue -> {DistRedV, D + 1}
                                           end,
                            {array:set(V, UpdatedDistV, CurrentDist), queue:in({V, NextColor, D + 1}, CurrentQ)};
                        true ->
                            {CurrentDist, CurrentQ}
                    end
                end, {Dist, RestQ}, Neighbors),

            bfs(NewQ, Adj, NewDist, N);
        {empty, _} ->
            lists:map(fun(I) ->
                          {DistRedI, DistBlueI} = array:get(I, Dist),
                          MinDist = min(DistRedI, DistBlueI),
                          if MinDist =:= infinity -> -1;
                             true -> MinDist
                          end
                      end, lists:seq(0, N-1))
    end.