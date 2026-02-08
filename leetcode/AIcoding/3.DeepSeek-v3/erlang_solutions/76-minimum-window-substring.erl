-spec min_window(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> unicode:unicode_binary().
min_window(S, T) ->
    SStr = unicode:characters_to_list(S),
    TStr = unicode:characters_to_list(T),
    case TStr of
        [] -> <<>>;
        _ ->
            Target = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, TStr),
            TargetCount = maps:size(Target),
            {Left, Right, Current, Count, Result} = {0, 0, #{}, 0, {0, 0, length(SStr) + 1}},
            FinalResult = scan(SStr, Target, TargetCount, Left, Right, Current, Count, Result),
            case FinalResult of
                {Start, End, _} when End - Start + 1 =< length(SStr) ->
                    SubStr = lists:sublist(SStr, Start + 1, End - Start + 1),
                    unicode:characters_to_binary(SubStr);
                _ -> <<>>
            end
    end.

scan(S, Target, TargetCount, Left, Right, Current, Count, Result) when Right < length(S) ->
    Char = lists:nth(Right + 1, S),
    NewCurrent = maps:update_with(Char, fun(V) -> V + 1 end, 1, Current),
    NewCount = case maps:is_key(Char, Target) andalso maps:get(Char, NewCurrent) =:= maps:get(Char, Target) of
                   true -> Count + 1;
                   false -> Count
               end,
    NewResult = case NewCount =:= TargetCount of
                    true ->
                        {NewLeft, NewCurrent1, NewCount1} = contract(S, Target, Left, Right, NewCurrent, NewCount),
                        CurrentLen = Right - NewLeft + 1,
                        case CurrentLen < element(3, Result) of
                            true -> {NewLeft, Right, CurrentLen};
                            false -> Result
                        end;
                    false -> Result
                end,
    scan(S, Target, TargetCount, Left, Right + 1, NewCurrent, NewCount, NewResult);
scan(_, _, _, _, _, _, _, Result) -> Result.

contract(S, Target, Left, Right, Current, Count) ->
    Char = lists:nth(Left + 1, S),
    case maps:is_key(Char, Target) of
        true ->
            case maps:get(Char, Current) =:= maps:get(Char, Target) of
                true ->
                    NewCurrent = maps:update_with(Char, fun(V) -> V - 1 end, Current),
                    {Left, NewCurrent, Count - 1};
                false ->
                    NewCurrent = maps:update_with(Char, fun(V) -> V - 1 end, Current),
                    contract(S, Target, Left + 1, Right, NewCurrent, Count)
            end;
        false ->
            contract(S, Target, Left + 1, Right, Current, Count)
    end.