-module(solution).
-export([large_group_positions/1]).

large_group_positions(S) ->
    large_group_positions(S, 1, 1, []).

large_group_positions([], _, _, Acc) ->
    lists:reverse(Acc);
large_group_positions([C | T], Pos, Count, Acc) ->
    case T of
        [C | _] ->
            large_group_positions(T, Pos + 1, Count + 1, Acc);
        _ ->
            if
                Count >= 3 ->
                    large_group_positions(T, Pos + 1, 1, [[Pos - Count + 1, Pos] | Acc]);
                true ->
                    large_group_positions(T, Pos + 1, 1, Acc)
            end
    end.