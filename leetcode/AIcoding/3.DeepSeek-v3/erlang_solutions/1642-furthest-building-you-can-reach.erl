-module(solution).
-export([furthest_building/2]).

furthest_building(Heights, Bricks) ->
    furthest_building(Heights, Bricks, 0, []).

furthest_building([_], _, Index, _) -> Index;
furthest_building([H1, H2 | Rest], Bricks, Index, Heap) ->
    Diff = H2 - H1,
    if
        Diff =< 0 ->
            furthest_building([H2 | Rest], Bricks, Index + 1, Heap);
        true ->
            NewHeap = insert(Heap, Diff),
            case Bricks - Diff >= 0 of
                true ->
                    furthest_building([H2 | Rest], Bricks - Diff, Index + 1, NewHeap);
                false ->
                    case NewHeap of
                        [] -> Index;
                        [Max | Tail] when Max > Diff ->
                            NewBricks = Bricks + Max - Diff,
                            furthest_building([H2 | Rest], NewBricks, Index + 1, insert(Tail, Diff));
                        _ ->
                            Index
                    end
            end
    end.

insert([], Val) -> [Val];
insert([H | T], Val) when Val > H -> [Val, H | T];
insert([H | T], Val) -> [H | insert(T, Val)].