-module(solution).
-export([max_area_rectangle/1]).

max_area_rectangle([]) ->
    0;
max_area_rectangle([[X, Y] | Rest]) ->
    {MinX, MaxX, MinY, MaxY} = lists:foldl(
        fun([PX, PY], {AccMinX, AccMaxX, AccMinY, AccMaxY}) ->
            {min(AccMinX, PX), max(AccMaxX, PX), min(AccMinY, PY), max(AccMaxY, PY)}
        end,
        {X, X, Y, Y},
        Rest
    ),
    Width = MaxX - MinX,
    Height = MaxY - MinY,
    Width * Height.