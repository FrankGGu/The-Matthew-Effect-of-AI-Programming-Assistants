-spec max_dist(points :: [[integer()]]) -> float().
max_dist(Points) ->
    N = length(Points),
    case N of
        2 -> 
            [X1, Y1] = lists:nth(1, Points),
            [X2, Y2] = lists:nth(2, Points),
            DX = abs(X1 - X2),
            DY = abs(Y1 - Y2),
            max(max(DX, DY), math:sqrt(DX * DX + DY * DY));
        _ ->
            MinX = lists:min([X || [X, _Y] <- Points]),
            MaxX = lists:max([X || [X, _Y] <- Points]),
            MinY = lists:min([Y || [_X, Y] <- Points]),
            MaxY = lists:max([Y || [_X, Y] <- Points]),
            D1 = MaxX - MinX,
            D2 = MaxY - MinY,
            D3 = math:sqrt((MaxX - MinX) * (MaxX - MinX) + (MaxY - MinY) * (MaxY - MinY)),
            max(max(D1, D2), D3)
    end.