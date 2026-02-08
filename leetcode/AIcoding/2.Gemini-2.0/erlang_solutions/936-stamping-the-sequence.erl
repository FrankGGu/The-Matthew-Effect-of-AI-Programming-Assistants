-module(stamping_the_sequence).
-export([movesToStamp/2]).

movesToStamp(Stamp, Target) ->
    movesToStamp_helper(Stamp, Target, []).

movesToStamp_helper(Stamp, Target, Acc) ->
    case stamp_once(Stamp, Target) of
        {NewTarget, Index} when Index >= 0 ->
            movesToStamp_helper(Stamp, NewTarget, [Index | Acc]);
        _ ->
            case is_all_question_marks(Target) of
                true ->
                    lists:reverse(Acc);
                false ->
                    []
            end
    end.

stamp_once(Stamp, Target) ->
    LenStamp = length(Stamp),
    LenTarget = length(Target),
    stamp_once_helper(Stamp, Target, LenStamp, LenTarget, 0).

stamp_once_helper(Stamp, Target, LenStamp, LenTarget, Index) when Index + LenStamp =< LenTarget ->
    Sub = lists:sublist(Target, Index + 1, LenStamp),
    case can_stamp(Stamp, Sub) of
        true ->
            NewTarget = replace(Target, Index + 1, LenStamp),
            {NewTarget, Index};
        false ->
            stamp_once_helper(Stamp, Target, LenStamp, LenTarget, Index + 1)
    end;
stamp_once_helper(_, _, _, _, Index) ->
    {Target, -1}.

can_stamp(Stamp, Sub) ->
    can_stamp_helper(Stamp, Sub, 1).

can_stamp_helper([], [], _) ->
    true;
can_stamp_helper([H1 | T1], [H2 | T2], Index) ->
    case H1 == H2 orelse H2 == '?' of
        true ->
            can_stamp_helper(T1, T2, Index + 1);
        false ->
            false
    end;
can_stamp_helper(_, _, _) ->
    false.

replace(Target, Start, Len) ->
    replace_helper(Target, Start, Len, []).

replace_helper([], _, _, Acc) ->
    lists:reverse(Acc);
replace_helper([H | T], Start, Len, Acc) when Start > 1 ->
    replace_helper(T, Start - 1, Len, [H | Acc]);
replace_helper([_ | T], 1, Len, Acc) when Len > 0 ->
    replace_helper(T, 1, Len - 1, ['?' | Acc]);
replace_helper([H | T], _, _, Acc) ->
    replace_helper(T, 0, 0, [H | Acc]).

is_all_question_marks(Target) ->
    is_all_question_marks_helper(Target).

is_all_question_marks_helper([]) ->
    true;
is_all_question_marks_helper([H | T]) ->
    case H == '?' of
        true ->
            is_all_question_marks_helper(T);
        false ->
            false
    end.