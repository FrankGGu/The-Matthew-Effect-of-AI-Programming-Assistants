-module(skyline).
-export([get_skyline/1]).

get_skyline(Buildings) ->
    Points = lists:foldl(fun({L, R, H}, Acc) ->
        [{L, H, right}, {R, H, left} | Acc]
    end, [], Buildings),
    SortedPoints = lists:sort(Points),
    process(SortedPoints, [], []).

process([], _, Result) ->
    Result;
process([{X, H, Type} | T], ActiveHeights, Result) ->
    case Type of
        right ->
            NewActiveHeights = lists:delete(H, ActiveHeights),
            NewResult = case NewActiveHeights of
                [] -> Result ++ [{X, 0}];
                _ -> Result ++ [{X, hd(lists:reverse(lists:sort(NewActiveHeights)))}]
            end,
            process(T, NewActiveHeights, NewResult);
        left ->
            NewActiveHeights = [H | ActiveHeights],
            NewResult = case ActiveHeights of
                [] -> Result ++ [{X, H}];
                _ -> Result ++ [{X, hd(lists:reverse(lists:sort(NewActiveHeights)))}]
            end,
            process(T, NewActiveHeights, NewResult)
    end.