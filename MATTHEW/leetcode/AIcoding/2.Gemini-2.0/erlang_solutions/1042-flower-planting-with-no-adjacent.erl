-module(flower_planting_no_adjacent).
-export([gardenNoAdj/2]).

gardenNoAdj(N, Paths) ->
    Graph = build_graph(N, Paths),
    plant_flowers(N, Graph).

build_graph(N, Paths) ->
    lists:foldl(
        fun(Path, Acc) ->
            [V1, V2] = Path,
            Acc1 = maps:update_with(V1, fun(Vs) -> [V2 | Vs] end, [V2], Acc),
            maps:update_with(V2, fun(Vs) -> [V1 | Vs] end, [V1], Acc1)
        end,
        maps:new(),
        Paths
    ).

plant_flowers(N, Graph) ->
    Flowers = lists:seq(1, N),
    plant_flowers_helper(Flowers, Graph, []).

plant_flowers_helper([], _, Acc) ->
    lists:reverse(Acc);
plant_flowers_helper([Garden | Rest], Graph, Acc) ->
    Neighbors = maps:get(Garden, Graph, []),
    UsedColors = get_used_colors(Neighbors, lists:zip(lists:seq(1,length(Acc)),Acc)),
    Color = get_available_color(UsedColors),
    plant_flowers_helper(Rest, Graph, [Color | Acc]).

get_used_colors(Neighbors, Flowers) ->
    lists:foldl(
        fun(Neighbor, Acc) ->
            case lists:keyfind(Neighbor, 1, Flowers) of
                {_, Color} -> [Color | Acc];
                false -> Acc
            end
        end,
        [],
        Neighbors
    ).

get_available_color(UsedColors) ->
    Colors = [1, 2, 3, 4],
    lists:foldl(
        fun(Color, Acc) ->
            case lists:member(Color, UsedColors) of
                true -> Acc;
                false -> [Color | Acc]
            end
        end,
        [],
        Colors
    ) hd.