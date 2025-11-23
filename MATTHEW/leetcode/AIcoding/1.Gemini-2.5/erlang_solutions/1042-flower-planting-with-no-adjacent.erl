-module(solution).
-export([flower_planting/2]).

-spec flower_planting(N :: integer(), Paths :: [[integer()]]) -> [integer()].
flower_planting(N, Paths) ->
    Adj = build_adj(N, Paths),
    color_gardens(1, N, Adj, #{}).

build_adj(_N, Paths) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
            maps:update_with(V, fun(List) -> [U | List] end, [U], Acc1)
        end,
        maps:new(),
        Paths
    ).

color_gardens(CurrentGarden, N, Adj, AssignedColors) when CurrentGarden =< N ->
    Neighbors = maps:get(CurrentGarden, Adj, []),

    UsedColors = lists:foldl(
        fun(Neighbor, Acc) ->
            case maps:find(Neighbor, AssignedColors) of
                {ok, Color} -> sets:add_element(Color, Acc);
                error -> Acc
            end
        end,
        sets:new(),
        Neighbors
    ),

    AvailableColor = find_available_color(UsedColors),

    NewAssignedColors = maps:put(CurrentGarden, AvailableColor, AssignedColors),

    color_gardens(CurrentGarden + 1, N, Adj, NewAssignedColors);
color_gardens(N + 1, N, _Adj, AssignedColors) ->
    [maps:get(I, AssignedColors) || I <- lists:seq(1, N)].

find_available_color(UsedColors) ->
    hd(lists:filter(fun(Color) -> not sets:is_element(Color, UsedColors) end, [1,2,3,4])).