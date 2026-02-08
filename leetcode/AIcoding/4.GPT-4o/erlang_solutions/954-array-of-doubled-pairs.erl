-module(solution).
-export([can_reorder_doubled/1]).

can_reorder_doubled(List) ->
    Sorted = lists:sort(List),
    can_reorder_doubled_helper(Sorted, []).

can_reorder_doubled_helper([], _) -> true;
can_reorder_doubled_helper([H|T], Seen) ->
    case lists:member(H, Seen) of
        true -> can_reorder_doubled_helper(T, Seen);
        false ->
            case lists:member(2 * H, T) of
                true ->
                    NewT = lists:delete(2 * H, T),
                    can_reorder_doubled_helper(NewT, [H | Seen]);
                false -> false
            end
    end.