-module(grid_average).
-export([averageGrid/1]).

averageGrid(Image) ->
    {Rows, Cols} = {length(Image), length(hd(Image))},
    Visited = array:new([Rows, Cols], false),
    Regions = findRegions(Image, Visited, []),
    updateImage(Image, Regions).

findRegions(Image, Visited, Acc) ->
    {Rows, Cols} = {length(Image), length(hd(Image))},
    findRegionHelper(Image, Visited, 0, 0, Rows, Cols, Acc).

findRegionHelper(Image, Visited, Row, Col, Rows, Cols, Acc) ->
    case {Row >= Rows, Col >= Cols} of
        {true, _} -> Acc;
        {false, true} -> findRegionHelper(Image, Visited, Row + 1, 0, Rows, Cols, Acc);
        {false, false} ->
            case array:get({Row, Col}, Visited) of
                true ->
                    findRegionHelper(Image, Visited, Row, Col + 1, Rows, Cols, Acc);
                false ->
                    Value = lists:nth(Row + 1, Image) !! (Col + 1),
                    case Value of
                        0 ->
                            findRegionHelper(Image, Visited, Row, Col + 1, Rows, Cols, Acc);
                        _ ->
                            {Region, NewVisited} = dfs(Image, Visited, Row, Col, Rows, Cols, []),
                            findRegionHelper(Image, NewVisited, Row, Col + 1, Rows, Cols, [Region | Acc])
                    end
            end
    end.

dfs(Image, Visited, Row, Col, Rows, Cols, Acc) ->
    case {Row < 0, Row >= Rows, Col < 0, Col >= Cols} of
        {true, _, _, _} -> {Acc, Visited};
        {_, true, _, _} -> {Acc, Visited};
        {_, _, true, _} -> {Acc, Visited};
        {_, _, _, true} -> {Acc, Visited};
        _ ->
            case array:get({Row, Col}, Visited) of
                true -> {Acc, Visited};
                false ->
                    Value = lists:nth(Row + 1, Image) !! (Col + 1),
                    case Value of
                        0 -> {Acc, Visited};
                        _ ->
                            NewVisited = array:set({Row, Col}, true, Visited),
                            {R1, V1} = dfs(Image, NewVisited, Row + 1, Col, Rows, Cols, [{Row, Col} | Acc]),
                            {R2, V2} = dfs(Image, V1, Row - 1, Col, Rows, Cols, R1),
                            {R3, V3} = dfs(Image, V2, Row, Col + 1, Rows, Cols, R2),
                            dfs(Image, V3, Row, Col - 1, Rows, Cols, R3)
                    end
            end
    end.

updateImage(Image, Regions) ->
    lists:map(fun(RowList) ->
                  lists:map(fun(_) -> 0 end, RowList)
              end, updateImageHelper(Image, Regions)).

updateImageHelper(Image, []) -> Image;
updateImageHelper(Image, [Region | Rest]) ->
    Sum = lists:foldl(fun({R, C}, Acc) -> Acc + (lists:nth(R + 1, Image) !! (C + 1)) end, 0, Region),
    Count = length(Region),
    Average = round(Sum / Count),
    updateRegion(Image, Region, Average, Rest).

updateRegion(Image, [], _, Rest) ->
    updateImageHelper(Image, Rest);
updateRegion(Image, [{Row, Col} | Tail], Average, Rest) ->
    RowList = lists:nth(Row + 1, Image),
    UpdatedRowList = lists:replace(Col + 1, Average, RowList),
    UpdatedImage = lists:replace(Row + 1, UpdatedRowList, Image),
    updateRegion(UpdatedImage, Tail, Average, Rest).