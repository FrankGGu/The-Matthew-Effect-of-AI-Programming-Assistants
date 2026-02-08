-module(furthest_building).
-export([furthestBuilding/2]).

furthestBuilding(Positions, Bricks) ->
    furthestBuilding(Positions, Bricks, 0, [], []).

furthestBuilding([], _Bricks, Index, _Heaps, _Used) ->
    Index;
furthestBuilding([H | T], Bricks, Index, Heaps, Used) ->
    Diff = H - lists:last(Positions),
    if
        Diff =< 0 ->
            furthestBuilding(T, Bricks, Index + 1, Heaps, Used);
        true ->
            case Heaps of
                [] ->
                    NewHeaps = [Diff],
                    furthestBuilding(T, Bricks, Index + 1, NewHeaps, Used);
                _ ->
                    case lists:member(Diff, Heaps) of
                        true ->
                            NewHeaps = lists:delete(Diff, Heaps),
                            NewHeaps2 = [Diff | NewHeaps],
                            furthestBuilding(T, Bricks, Index + 1, NewHeaps2, Used);
                        false ->
                            case length(Heaps) < Bricks of
                                true ->
                                    NewHeaps = lists:insert(1, Diff, Heaps),
                                    furthestBuilding(T, Bricks, Index + 1, NewHeaps, Used);
                                false ->
                                    Min = lists:min(Heaps),
                                    if
                                        Diff < Min ->
                                            NewHeaps = lists:delete(Min, Heaps),
                                            NewHeaps2 = [Diff | NewHeaps],
                                            furthestBuilding(T, Bricks, Index + 1, NewHeaps2, Used);
                                        true ->
                                            furthestBuilding(T, Bricks, Index, Heaps, Used)
                                    end
                            end
                    end
            end
    end.