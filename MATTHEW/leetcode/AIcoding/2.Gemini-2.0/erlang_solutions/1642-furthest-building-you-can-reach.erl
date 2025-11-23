-module(furthest_building).
-export([furthest_building/3]).

furthest_building(Heights, Bricks, Ladders) ->
    furthest_building(Heights, Bricks, Ladders, 0).

furthest_building(Heights, Bricks, Ladders, Index) when Index >= length(Heights) - 1 ->
    length(Heights) - 1;
furthest_building(Heights, Bricks, Ladders, Index) ->
    H1 = lists:nth(Index + 1, Heights),
    H2 = lists:nth(Index + 1, Heights),
    H0 = lists:nth(Index + 1, Heights),
    H = lists:nth(Index + 1, Heights) - lists:nth(Index + 1 - 1, Heights),

    case H > 0 of
        true ->
            case Bricks >= H of
                true ->
                    furthest_building(Heights, Bricks - H, Ladders, Index + 1);
                false ->
                    case Ladders > 0 of
                        true ->
                            Sorted = sort_diffs(Heights, Index),

                            case Sorted of
                                [] ->
                                    Index;
                                [First | Rest] ->
                                    case Ladders > 0 of
                                        true ->
                                            case First >= H of
                                                true ->
                                                    furthest_building(Heights, Bricks, Ladders - 1, Index + 1);
                                                false ->
                                                    Index
                                            end;
                                        false ->
                                            Index
                                    end
                            end;
                        false ->
                            Index
                    end
            end;
        false ->
            furthest_building(Heights, Bricks, Ladders, Index + 1)
    end.

sort_diffs(Heights, Index) ->
    Diffs = get_diffs(Heights, Index),
    lists:sort(fun(A, B) -> A > B end, Diffs).

get_diffs(Heights, Index) ->
    get_diffs(Heights, Index, 0, []).

get_diffs(Heights, Index, I, Acc) when I >= Index ->
    Acc;
get_diffs(Heights, Index, I, Acc) ->
    H = lists:nth(I + 1, Heights) - lists:nth(I + 1 - 1, Heights),
    case H > 0 of
        true ->
            get_diffs(Heights, Index, I + 1, [H | Acc]);
        false ->
            get_diffs(Heights, Index, I + 1, Acc)
    end.