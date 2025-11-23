-module(solution).
-export([countGoodRectangles/1]).

countGoodRectangles(Rectangles) ->
    lists:foldl(fun(Rectangle, {MaxSide, Count}) ->
                        Side = min(lists:nth(1, Rectangle), lists:nth(2, Rectangle)),
                        case Side > MaxSide of
                            true -> {Side, 1};
                            false ->
                                case Side =:= MaxSide of
                                    true -> {MaxSide, Count + 1};
                                    false -> {MaxSide, Count}
                                end
                        end
                end, {0, 0}, Rectangles).

countGoodRectangles(Rectangles) ->
    {_, Count} = lists:foldl(fun(Rectangle, {MaxSide, Count}) ->
                        Side = min(lists:nth(1, Rectangle), lists:nth(2, Rectangle)),
                        if
                            Side > MaxSide ->
                                {Side, 1};
                            Side =:= MaxSide ->
                                {MaxSide, Count + 1};
                            true ->
                                {MaxSide, Count}
                        end
                end, {0, 0}, Rectangles),
    Count.