-module(selling_pieces_of_wood).
-export([sell_pieces/2]).

sell_pieces(H, W) ->
    sell_pieces(H, W, 1, 1, 0).

sell_pieces(H, W, R, C, Max) ->
    case R of
        R when R > H -> Max;
        _ ->
            case C of
                C when C > W -> sell_pieces(H, W, R + 1, 1, Max);
                _ ->
                    Price = (H - R + 1) * (W - C + 1),
                    NewMax = max(Max, Price),
                    sell_pieces(H, W, R, C + 1, NewMax)
            end
    end.