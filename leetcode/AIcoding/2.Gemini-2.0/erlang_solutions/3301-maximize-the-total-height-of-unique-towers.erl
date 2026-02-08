-module(solution).
-export([maximize_tower_heights/1]).

maximize_tower_heights(tower_heights) ->
    maximize_tower_heights(lists:sort(tower_heights), []).

maximize_tower_heights([], Acc) ->
    lists:sum(Acc);
maximize_tower_heights([H|T], Acc) ->
    case lists:member(H, Acc) of
        true ->
            case H > 1 of
                true ->
                    maximize_tower_heights([H - 1 | T], Acc);
                false ->
                    maximize_tower_heights(T, Acc)
            end;
        false ->
            maximize_tower_heights(T, [H | Acc])
    end.