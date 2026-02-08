-spec robot_with_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
robot_with_string(S) ->
    SList = unicode:characters_to_list(S),
    Stack = [],
    Res = [],
    Freq = lists:foldl(fun(Char, Acc) -> 
                           maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, SList),
    {Result, _} = process(SList, Stack, Res, Freq),
    unicode:characters_to_binary(Result).

process([], [], Res, _Freq) ->
    {lists:reverse(Res), []};
process([], Stack, Res, Freq) ->
    {lists:reverse(Res) ++ Stack, []};
process([H | T], Stack, Res, Freq) ->
    case Stack of
        [] ->
            process(T, [H | Stack], Res, decrement_freq(H, Freq));
        [Top | _] ->
            case find_min(Freq) of
                Min when Min < Top ->
                    process(T, [H | Stack], Res, decrement_freq(H, Freq));
                _ ->
                    process([H | T], tl(Stack), [Top | Res], Freq)
            end
    end.

decrement_freq(Char, Freq) ->
    case maps:get(Char, Freq) of
        1 -> maps:remove(Char, Freq);
        N -> maps:put(Char, N - 1, Freq)
    end.

find_min(Freq) ->
    case maps:size(Freq) of
        0 -> 127; % 'z' + 1
        _ -> lists:min(maps:keys(Freq))
    end.