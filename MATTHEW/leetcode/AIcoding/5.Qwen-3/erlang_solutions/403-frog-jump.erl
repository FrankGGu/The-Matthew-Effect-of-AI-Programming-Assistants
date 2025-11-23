-module(frog_jump).
-export([can_cross/1]).

can_cross(Stones) ->
    can_cross(Stones, 0, 0, maps:new()).

can_cross([], _, _, _) ->
    true;
can_cross([_], _, _, _) ->
    true;
can_cross([First | Rest], Step, Index, Memo) ->
    Key = {Index, Step},
    case maps:is_key(Key, Memo) of
        true ->
            maps:get(Key, Memo);
        false ->
            Result = can_cross_helper(Rest, First, Index + 1, Step, Memo),
            maps:put(Key, Result, Memo),
            Result
    end.

can_cross_helper([], _, _, _, _) ->
    true;
can_cross_helper([Second | Rest], First, Index, Step, Memo) ->
    Diff = Second - First,
    if
        Diff < 1 ->
            can_cross_helper(Rest, Second, Index + 1, Step, Memo);
        true ->
            case Diff of
                Step ->
                    can_cross([Second | Rest], Step, Index, Memo);
                Step + 1 ->
                    can_cross([Second | Rest], Step + 1, Index, Memo);
                _ ->
                    can_cross_helper(Rest, Second, Index + 1, Step, Memo)
            end
    end.