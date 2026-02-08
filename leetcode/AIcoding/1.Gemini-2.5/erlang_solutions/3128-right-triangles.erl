-module(solution).
-export([rightTriangles/1]).

rightTriangles(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),

    RowCounts = array:new(R, {default, 0}),
    ColCounts = array:new(C, {default, 0}),

    {FinalRowCounts, FinalColCounts, _} =
        lists:foldl(fun(Row, {AccRowCounts, AccColCounts, RIndex}) ->
                        {NewRowCounts, NewColCounts, _} =
                            lists:foldl(fun(Cell, {CurrentRowCounts, CurrentColCounts, CIndex}) ->
                                            if Cell == 1 ->
                                                UpdatedRowCounts = array:set(RIndex, array:get(RIndex, CurrentRowCounts) + 1, CurrentRowCounts),
                                                UpdatedColCounts = array:set(CIndex, array:get(CIndex, CurrentColCounts) + 1, CurrentColCounts),
                                                {UpdatedRowCounts, UpdatedColCounts, CIndex + 1};
                                            true ->
                                                {CurrentRowCounts, CurrentColCounts, CIndex + 1}
                                            end
                                        end, {AccRowCounts, AccColCounts, 0}, Row),
                        {NewRowCounts, NewColCounts, RIndex + 1}
                    end, {RowCounts, ColCounts, 0}, Grid),

    TotalTriangles =
        lists:foldl(fun(Row, {AccTotal, RIndex}) ->
                        {NewTotal, _} =
                            lists:foldl(fun(Cell, {CurrentTotal, CIndex}) ->
                                            if Cell == 1 ->
                                                RowCount = array:get(RIndex, FinalRowCounts),
                                                ColCount = array:get(CIndex, FinalColCounts),
                                                Triangles = (RowCount - 1) * (ColCount - 1),
                                                {CurrentTotal + Triangles, CIndex + 1};
                                            true ->
                                                {CurrentTotal, CIndex + 1}
                                            end
                                        end, {AccTotal, 0}, Row),
                        {NewTotal, RIndex + 1}
                    end, {0, 0}, Grid),

    element(1, TotalTriangles).