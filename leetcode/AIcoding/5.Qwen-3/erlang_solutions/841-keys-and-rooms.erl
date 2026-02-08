-module(keys_and_rooms).
-export([can_visit_all/1]).

can_visit_all(Rooms) ->
    can_visit_all(Rooms, 0, gb_sets:from_list([0])).

can_visit_all(_, _, Visited) when gb_sets:size(Visited) == length(Rooms) ->
    true;
can_visit_all(Rooms, Index, Visited) ->
    case gb_sets:is_element(Index, Visited) of
        true ->
            Next = lists:nth(Index + 1, Rooms),
            NewVisited = lists:foldl(fun(Key, Acc) -> gb_sets:add(Key, Acc) end, Visited, Next),
            can_visit_all(Rooms, Index + 1, NewVisited);
        false ->
            can_visit_all(Rooms, Index + 1, Visited)
    end.