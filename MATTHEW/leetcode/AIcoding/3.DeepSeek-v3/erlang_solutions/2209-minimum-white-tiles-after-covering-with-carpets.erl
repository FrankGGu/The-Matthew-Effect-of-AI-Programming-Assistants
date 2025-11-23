-module(solution).
-export([minimum_white_tiles/3]).

minimum_white_tiles(Floor, NumCarpets, CarpetLen) ->
    N = length(Floor),
    DP = lists:duplicate(N + 1, lists:duplicate(NumCarpets + 1, 0)),
    {_, _, Result} = lists:foldl(fun(I, {PrevDP, FloorList, _}) ->
        White = if 
            lists:nth(I, FloorList) == $1 -> 1;
            true -> 0
        end,
        NewRow = lists:foldl(fun(K, Acc) ->
            case K of
                0 -> 
                    [lists:nth(I, lists:nth(1, PrevDP)) + White | Acc];
                _ ->
                    NotCover = lists:nth(I, lists:nth(K + 1, PrevDP)) + White,
                    Cover = if 
                        I > CarpetLen -> lists:nth(I - CarpetLen, lists:nth(K, PrevDP)));
                        true -> 0
                    end,
                    [min(NotCover, Cover) | Acc]
            end
        end, [], lists:seq(0, NumCarpets)),
        {[lists:reverse(NewRow) | PrevDP], FloorList, lists:nth(NumCarpets + 1, hd([lists:reverse(NewRow) | PrevDP])))}
    end, {DP, Floor, 0}, lists:seq(1, N)),
    Result.