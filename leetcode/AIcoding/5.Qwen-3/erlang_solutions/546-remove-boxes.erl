-module(remove_boxes).
-export([remove_boxes/1]).

remove_boxes(Boxes) ->
    remove_boxes(Boxes, 0, erlang:length(Boxes) - 1, 0).

remove_boxes(_, Left, Right, _) when Left > Right ->
    0;
remove_boxes(Boxes, Left, Right, Count) when Left == Right ->
    Count * Count * lists:nth(Left + 1, Boxes);
remove_boxes(Boxes, Left, Right, Count) ->
    Key = {Left, Right, Count},
    case ets:lookup(?MODULE, Key) of
        [] ->
            Best = best_remove(Boxes, Left, Right, Count),
            ets:insert(?MODULE, {Key, Best}),
            Best;
        [{_, Val}] ->
            Val
    end.

best_remove(Boxes, Left, Right, Count) ->
    Max = 0,
    Best = lists:foldl(
        fun(I, Acc) ->
            if I == Left -> Acc;
               true ->
                    if lists:nth(I + 1, Boxes) == lists:nth(Left + 1, Boxes) ->
                            NewCount = Count + 1,
                            Current = remove_boxes(Boxes, Left + 1, I - 1, 0) +
                                     remove_boxes(Boxes, I, Right, NewCount),
                            if Current > Acc -> Current;
                               true -> Acc
                            end;
                       true ->
                            Current = remove_boxes(Boxes, Left + 1, I - 1, 0) +
                                     remove_boxes(Boxes, I, Right, Count),
                            if Current > Acc -> Current;
                               true -> Acc
                            end
                    end
            end
        end,
        0,
        lists:seq(Left, Right)
    ),
    Max.

init_ets() ->
    ets:new(?MODULE, [set, public, named_table]).

-compile(export_all).