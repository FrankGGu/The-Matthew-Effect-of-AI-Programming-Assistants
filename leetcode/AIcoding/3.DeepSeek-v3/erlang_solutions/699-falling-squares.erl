-module(falling_squares).
-export([falling_squares/1]).

falling_squares(Positions) ->
    Heights = lists:foldl(fun({Left, SideLen}, Acc) ->
        Right = Left + SideLen,
        CurrentHeight = get_max_height(Acc, Left, Right),
        NewHeight = CurrentHeight + SideLen,
        update_heights(Acc, Left, Right, NewHeight)
    end, [], Positions),
    get_cumulative_max(Heights, []).

get_max_height(Intervals, Left, Right) ->
    MaxHeight = lists:foldl(fun({L, R, H}, Acc) ->
        case (R > Left) and (L < Right) of
            true -> max(Acc, H);
            false -> Acc
        end
    end, 0, Intervals),
    MaxHeight.

update_heights(Intervals, Left, Right, NewHeight) ->
    NewIntervals = lists:foldl(fun({L, R, H}, Acc) ->
        if
            R <= Left; L >= Right -> [{L, R, H} | Acc];
            true -> 
                if
                    L < Left -> [{L, Left, H} | Acc];
                    true -> Acc
                end ++
                if
                    R > Right -> [{Right, R, H} | Acc];
                    true -> Acc
                end
        end
    end, [], Intervals),
    [{Left, Right, NewHeight} | NewIntervals].

get_cumulative_max(Intervals, Acc) ->
    case Intervals of
        [] -> lists:reverse(Acc);
        _ ->
            CurrentMax = lists:foldl(fun({_, _, H}, Max) -> max(Max, H) end, 0, Intervals),
            get_cumulative_max(tl(Intervals), [CurrentMax | Acc])
    end.