-module(solution).
-export([count_lattice_points/1]).

count_lattice_points(Circles) ->
    UniquePoints = sets:new(),
    lists:foldl(fun(Circle, AccPoints) ->
                    [Cx, Cy, R] = Circle,
                    R2 = R * R,
                    MinX = Cx - R,
                    MaxX = Cx + R,
                    MinY = Cy - R,
                    MaxY = Cy + R,
                    lists:foldl(fun(X, AccPoints1) ->
                                    lists:foldl(fun(Y, AccPoints2) ->
                                                    Dx = X - Cx,
                                                    Dy = Y - Cy,
                                                    If (Dx*Dx + Dy*Dy =< R2) ->
                                                        sets:add_element({X, Y}, AccPoints2);
                                                    Else ->
                                                        AccPoints2
                                                    End
                                                End, AccPoints1, lists:seq(MinY, MaxY))
                                End, AccPoints, lists:seq(MinX, MaxX))
                End, UniquePoints, Circles),
    sets:size(UniquePoints).