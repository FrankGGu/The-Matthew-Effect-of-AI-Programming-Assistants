-module(making_a_large_island).
-export([largestIsland/1]).

largestIsland(Grid) ->
    {Rows, Cols} = {length(Grid), length(hd(Grid))},
    Id = 2,
    Islands = maps:new(),
    IdMap = grid_to_id_map(Grid, Rows, Cols, Id, Islands, []),
    {MaxArea, _} = find_max_area(IdMap, 0),
    case MaxArea of
        0 -> if Rows == 0 orelse Cols == 0 -> 0; true -> 1 end;
        _ -> MaxArea
    end.

grid_to_id_map([], _, _, _, _, Acc) ->
    lists:reverse(Acc);
grid_to_id_map([Row | Rest], Rows, Cols, Id, Islands, Acc) ->
    NewAcc = grid_to_id_row(Row, 0, Id, Rows, Cols, Islands, []),
    grid_to_id_map(Rest, Rows, Cols, Id + 1, Islands, [NewAcc | Acc]).

grid_to_id_row([], _, _, _, _, _, Acc) ->
    lists:reverse(Acc);
grid_to_id_row([Val | Rest], Col, Id, Rows, Cols, Islands, Acc) ->
    if Val == 1 ->
           {NewId, NewIslands} = get_or_assign_id(Islands, Id),
           grid_to_id_row(Rest, Col + 1, Id + 1, Rows, Cols, NewIslands, [{Col, NewId} | Acc]);
       true ->
           grid_to_id_row(Rest, Col + 1, Id, Rows, Cols, Islands, [none | Acc])
    end.

get_or_assign_id(Islands, Id) ->
    case maps:is_key(Id, Islands) of
        true -> {Id, Islands};
        false -> {Id, maps:put(Id, 1, Islands)}
    end.

find_max_area([], Max) ->
    {Max, 0};
find_max_area([{Col, Id} | Rest], Max) ->
    case maps:get(Id, maps:new(), 0) of
        0 -> find_max_area(Rest, Max);
        Area ->
            NewMax = max(Max, Area),
            find_max_area(Rest, NewMax)
    end.

grid_to_id_row([], _, _, _, _, _, Acc) ->
    lists:reverse(Acc);
grid_to_id_row([Val | Rest], Col, Id, Rows, Cols, Islands, Acc) ->
    if Val == 1 ->
           {NewId, NewIslands} = get_or_assign_id(Islands, Id),
           grid_to_id_row(Rest, Col + 1, Id + 1, Rows, Cols, NewIslands, [{Col, NewId} | Acc]);
       true ->
           grid_to_id_row(Rest, Col + 1, Id, Rows, Cols, Islands, [none | Acc])
    end.