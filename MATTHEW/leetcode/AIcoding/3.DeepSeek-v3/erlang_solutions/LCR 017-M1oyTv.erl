-spec min_window(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> unicode:unicode_binary().
min_window(S, T) ->
    SStr = unicode:characters_to_list(S),
    TStr = unicode:characters_to_list(T),
    case TStr of
        [] -> <<>>;
        _ ->
            Target = lists:foldl(fun(Char, Acc) -> 
                                    maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                                end, #{}, TStr),
            TargetLen = length(TStr),
            {Left, Right, MinLeft, MinLen} = scan(SStr, Target, TargetLen, 0, 0, 0, (1 bsl 31) - 1),
            if
                MinLen =:= ((1 bsl 31) - 1) -> <<>>;
                true -> 
                    SubStr = lists:sublist(SStr, MinLeft + 1, MinLen),
                    unicode:characters_to_binary(SubStr)
            end
    end.

scan(S, Target, TargetLen, Left, Right, Count, MinLen) when Right < length(S) ->
    Char = lists:nth(Right + 1, S),
    case maps:find(Char, Target) of
        {ok, Val} ->
            NewTarget = maps:put(Char, Val - 1, Target),
            NewCount = if Val > 0 -> Count + 1; true -> Count end,
            if
                NewCount =:= TargetLen ->
                    {NewLeft, NewLeftPos, NewTarget2} = move_left(S, Left, Right, NewTarget),
                    CurrentLen = Right - NewLeftPos + 1,
                    if
                        CurrentLen < MinLen ->
                            scan(S, NewTarget2, TargetLen, NewLeft, Right + 1, NewCount - 1, CurrentLen, NewLeftPos, CurrentLen);
                        true ->
                            scan(S, NewTarget2, TargetLen, NewLeft, Right + 1, NewCount - 1, MinLen, MinLeft, MinLen)
                    end;
                true ->
                    scan(S, NewTarget, TargetLen, Left, Right + 1, NewCount, MinLen, MinLeft, MinLen)
            end;
        error ->
            scan(S, Target, TargetLen, Left, Right + 1, Count, MinLen, MinLeft, MinLen)
    end;
scan(_S, _Target, _TargetLen, _Left, _Right, _Count, MinLen, MinLeft, _MinLen) ->
    {Left, Right, MinLeft, MinLen}.

scan(S, Target, TargetLen, Left, Right, Count, MinLen, MinLeft, CurrentMinLen) ->
    if
        Count =:= TargetLen ->
            {NewLeft, NewLeftPos, NewTarget} = move_left(S, Left, Right, Target),
            CurrentLen = Right - NewLeftPos + 1,
            if
                CurrentLen < CurrentMinLen ->
                    scan(S, NewTarget, TargetLen, NewLeft, Right + 1, Count - 1, CurrentLen, NewLeftPos, CurrentLen);
                true ->
                    scan(S, NewTarget, TargetLen, NewLeft, Right + 1, Count - 1, MinLen, MinLeft, CurrentMinLen)
            end;
        true ->
            scan(S, Target, TargetLen, Left, Right + 1, Count, MinLen, MinLeft, CurrentMinLen)
    end.

move_left(S, Left, Right, Target) ->
    Char = lists:nth(Left + 1, S),
    case maps:find(Char, Target) of
        {ok, Val} ->
            NewTarget = maps:put(Char, Val + 1, Target),
            if
                Val >= 0 ->
                    {Left + 1, Left, NewTarget};
                true ->
                    move_left(S, Left + 1, Right, NewTarget)
            end;
        error ->
            move_left(S, Left + 1, Right, Target)
    end.