-module(solution).
-export([shortest_sequence/2]).

shortest_sequence(Rolls, K) ->
    shortest_sequence(Rolls, K, sets:new(), 0, 0).

shortest_sequence([H | T], K, Set, Count, Res) ->
    case sets:is_element(H, Set) of
        false ->
            NewSet = sets:add_element(H, Set),
            NewCount = Count + 1,
            if
                NewCount =:= K ->
                    shortest_sequence(T, K, sets:new(), 0, Res + 1);
                true ->
                    shortest_sequence(T, K, NewSet, NewCount, Res)
            end;
        true ->
            shortest_sequence(T, K, Set, Count, Res)
    end;
shortest_sequence([], _K, _Set, _Count, Res) ->
    Res + 1.