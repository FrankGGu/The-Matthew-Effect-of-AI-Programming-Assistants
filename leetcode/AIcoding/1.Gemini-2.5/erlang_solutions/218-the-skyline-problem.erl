-module(solution).
-export([getSkyline/1]).

getSkyline(Buildings) ->
    Events = lists:foldl(fun([L, R, H], Acc) ->
                                 [{L, -H, H}, {R, H, H} | Acc]
                         end, [], Buildings),

    SortedEvents = lists:sort(fun({X1, Type1, _}, {X2, Type2, _}) ->
                                      if
                                          X1 =:= X2 -> Type1 < Type2;
                                          true -> X1 < X2
                                      end
                              end, Events),

    InitialActiveHeights = gb_trees:insert(0, 1, gb_trees:empty()),

    lists:foldl(fun({X, TypeHeight, OriginalHeight}, {AccSkyline, ActiveHeights, PrevMaxHeight}) ->
                        NewActiveHeights =
                            if
                                TypeHeight < 0 -> % Start event
                                    gb_trees:update(OriginalHeight, fun(Count) -> Count + 1 end, 1, ActiveHeights);
                                true -> % End event
                                    case gb_trees:lookup(OriginalHeight, ActiveHeights) of
                                        {value, 1} -> gb_trees:delete(OriginalHeight, ActiveHeights);
                                        {value, Count} -> gb_trees:update(OriginalHeight, fun(_) -> Count - 1 end, ActiveHeights)
                                    end
                            end,

                        {NewMaxHeight, _} = gb_trees:max(NewActiveHeights),

                        if
                            NewMaxHeight =/= PrevMaxHeight ->
                                {[X, NewMaxHeight] | AccSkyline, NewActiveHeights, NewMaxHeight};
                            true ->
                                {AccSkyline, NewActiveHeights, PrevMaxHeight}
                        end
                end, {[], InitialActiveHeights, 0}, SortedEvents)
    |> fun({SkylinePoints, _, _}) -> lists:reverse(SkylinePoints) end.