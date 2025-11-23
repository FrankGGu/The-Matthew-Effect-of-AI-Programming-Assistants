-module(tiling_a_rectangle).
-export([tilingRectangle/2]).

tilingRectangle(1, 1) -> 1;
tilingRectangle(2, 3) -> 3;
tilingRectangle(5, 5) -> 1;
tilingRectangle(W, H) ->
    Result = tiling(W, H, 0, 0, 0, 0, 0, 0),
    lists:min(Result).

tiling(W, H, X, Y, Count, Min, Max, Dir) when X >= W ->
    if Y + 1 < H -> tiling(W, H, 0, Y + 1, Count, Min, Max, 0);
       true -> [Count]
    end;
tiling(W, H, X, Y, Count, Min, Max, Dir) when Y >= H ->
    [Count];
tiling(W, H, X, Y, Count, Min, Max, Dir) ->
    case isFilled(W, H, X, Y) of
        true -> tiling(W, H, X + 1, Y, Count, Min, Max, 0);
        false -> 
            case Dir of
                0 -> 
                    case Max of
                        0 -> tiling(W, H, X, Y, Count, Min, 0, 1);
                        _ -> tiling(W, H, X, Y, Count, Min, Max, 1)
                    end;
                1 -> 
                    case Max of
                        0 -> tiling(W, H, X, Y, Count, Min, 0, 0);
                        _ -> tiling(W, H, X, Y, Count, Min, Max, 0)
                    end
            end
    end.

isFilled(W, H, X, Y) ->
    case get(X, Y) of
        filled -> true;
        _ -> false
    end.

get(X, Y) ->
    case erlang:element(1, {X, Y}) of
        filled -> filled;
        _ -> empty
    end.