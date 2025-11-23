-module(k_highest_ranked_items).
-export([highest_ranked_k_items/5]).

highest_ranked_k_items(Grid, Pricing, Start, K) ->
    Low, High = Pricing,
    {StartX, StartY} = Start,
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    ValidItems =
        lists:filter(
            fun(
                {X, Y}
            ) ->
                X >= 0 and X < Rows and Y >= 0 and Y < Cols and
                    ListItem = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
                ListItem >= Low and ListItem <= High and ListItem > 0
            end,
            lists:foldl(
                fun(X, Acc) ->
                    lists:foldl(
                        fun(Y, InnerAcc) ->
                            [ {X, Y} | InnerAcc]
                        end,
                        Acc,
                        lists:seq(0, Cols - 1)
                    )
                end,
                [],
                lists:seq(0, Rows - 1)
            )
        ),

    Distances =
        lists:map(
            fun(
                {X, Y}
            ) ->
                {distance({X, Y}, {StartX, StartY}, Grid), X, Y}
            end,
            ValidItems
        ),

    SortedDistances =
        lists:keysort(
            1,
            lists:map(
                fun({Dist, X, Y}) ->
                    Item = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
                    {Dist, Item, X, Y}
                end,
                Distances
            )
        ),

    lists:map(fun({_,_,X,Y}) -> [X,Y] end, lists:sublist(SortedDistances, 1, min(K, length(SortedDistances)))).

distance({X1, Y1}, {X2, Y2}, Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    Queue = [{X1, Y1, 0}],
    Visited = sets:new(),

    distance_helper(Queue, {X2,Y2}, Grid, Rows, Cols, sets:add({X1, Y1}, Visited)).

distance_helper([], {X2, Y2}, _Grid, _Rows, _Cols, _Visited) ->
    100000000;
distance_helper([{X, Y, Dist} | Rest], {X, Y}, _Grid, _Rows, _Cols, _Visited) ->
    Dist;
distance_helper([{X, Y, Dist} | Rest], Target, Grid, Rows, Cols, Visited) ->
    Neighbors = get_neighbors(X, Y, Grid, Rows, Cols, Visited),
    NewQueue = Rest ++ lists:map(fun({NX, NY}) -> {NX, NY, Dist+1} end, Neighbors),

    NewVisited = lists:foldl(fun({NX,NY}, Acc) -> sets:add({NX,NY}, Acc) end, Visited, Neighbors),

    distance_helper(NewQueue, Target, Grid, Rows, Cols, NewVisited).

get_neighbors(X, Y, Grid, Rows, Cols, Visited) ->
    ValidNeighbors = lists:filter(
        fun(
            {NX, NY}
        ) ->
            NX >= 0 and NX < Rows and NY >= 0 and NY < Cols and
                ListItem = lists:nth(NY + 1, lists:nth(NX + 1, Grid)),
            ListItem > 0 and not sets:is_element({NX,NY}, Visited)
        end,
        [{X - 1, Y}, {X + 1, Y}, {X, Y - 1}, {X, Y + 1}]
    ),
    ValidNeighbors.