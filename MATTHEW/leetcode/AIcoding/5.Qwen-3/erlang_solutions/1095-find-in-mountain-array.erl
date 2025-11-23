-module(mountain_array).
-export([find_in_mountain_array/2]).

find_in_mountain_array(Mountain, Target) ->
    find_in_mountain_array(Mountain, Target, 0, length(Mountain) - 1).

find_in_mountain_array(Mountain, Target, Left, Right) when Left =< Right ->
    Mid = (Left + Right) div 2,
    Val = lists:nth(Mid + 1, Mountain),
    case Val of
        Target -> Mid;
        _ ->
            case is_peak(Mountain, Mid) of
                true ->
                    case Target < Val of
                        true -> find_in_mountain_array(Mountain, Target, Left, Mid - 1);
                        false -> find_in_mountain_array(Mountain, Target, Mid + 1, Right)
                    end;
                false ->
                    case Val > lists:nth(Mid, Mountain) of
                        true ->
                            case Target < Val of
                                true -> find_in_mountain_array(Mountain, Target, Left, Mid - 1);
                                false -> find_in_mountain_array(Mountain, Target, Mid + 1, Right)
                            end;
                        false ->
                            case Target > Val of
                                true -> find_in_mountain_array(Mountain, Target, Mid + 1, Right);
                                false -> find_in_mountain_array(Mountain, Target, Left, Mid - 1)
                            end
                    end
            end
    end;
find_in_mountain_array(_, _, _, _) -> -1.

is_peak(Mountain, Index) ->
    Len = length(Mountain),
    Left = if Index - 1 >= 0 -> lists:nth(Index, Mountain); true -> -1 end,
    Current = lists:nth(Index + 1, Mountain),
    Right = if Index + 1 < Len -> lists:nth(Index + 2, Mountain); true -> -1 end,
    Current > Left andalso Current > Right.