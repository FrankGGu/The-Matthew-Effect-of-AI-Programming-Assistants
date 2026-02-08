-module(move_pieces).
-export([can_change/2]).

can_change(Start, Target) ->
    StartNoX = lists:filter(fun(C) -> C /= $\s  end, Start),
    TargetNoX = lists:filter(fun(C) -> C /= $\s end, Target),

    if StartNoX /= TargetNoX then
        false
    else
        can_change_helper(Start, Target, 0, 0)
    end.

can_change_helper(Start, Target, StartIdx, TargetIdx) ->
    if StartIdx >= length(Start) and TargetIdx >= length(Target) then
        true
    else
        case {get_char(Start, StartIdx), get_char(Target, TargetIdx)} of
            {$\s, _} ->
                can_change_helper(Start, Target, StartIdx + 1, TargetIdx);
            {_,$\s} ->
                can_change_helper(Start, Target, StartIdx, TargetIdx + 1);
            {L, L} ->
                case L of
                    $L ->
                        if find_first_non_x(lists:sublist(Start, 1, StartIdx)) < find_first_non_x(lists:sublist(Target, 1, TargetIdx)) then
                            can_change_helper(Start, Target, StartIdx + 1, TargetIdx + 1)
                        else
                            false
                        end;
                    $R ->
                        if find_last_non_x(lists:sublist(Start, 1, StartIdx + 1)) > find_last_non_x(lists:sublist(Target, 1, TargetIdx + 1)) then
                            can_change_helper(Start, Target, StartIdx + 1, TargetIdx + 1)
                        else
                            false
                        end
                end;
            _ ->
                false
        end
    end.

get_char(Str, Idx) ->
    try
        lists:nth(Idx + 1, Str)
    catch
        _:_ ->
            $\s
    end.

find_first_non_x(Str) ->
    find_first_non_x_helper(Str, 0).

find_first_non_x_helper([], _) ->
    infinity;
find_first_non_x_helper([H | T], Idx) ->
    if H /= $\s then
        Idx
    else
        find_first_non_x_helper(T, Idx + 1)
    end.

find_last_non_x(Str) ->
    find_last_non_x_helper(lists:reverse(Str), 0).

find_last_non_x_helper([], _) ->
    neg_infinity;
find_last_non_x_helper([H | T], Idx) ->
    if H /= $\s then
        length(T)
    else
        find_last_non_x_helper(T, Idx + 1)
    end.

infinity -> 1000000.
neg_infinity -> -1000000.