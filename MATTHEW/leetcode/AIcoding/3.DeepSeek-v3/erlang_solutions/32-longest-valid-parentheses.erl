-spec longest_valid_parentheses(S :: unicode:unicode_binary()) -> integer().
longest_valid_parentheses(S) ->
    SList = binary_to_list(S),
    MaxLen = 0,
    Stack = [-1],
    {FinalMax, _} = lists:foldl(fun
        ($), {Max, [Top | Rest] = StackAcc}) ->
            case Top /= -1 andalso lists:nth(Top + 1, SList) == $( of
                true ->
                    NewStack = Rest,
                    NewMax = max(Max, length(SList) - hd(NewStack) - 1),
                    {NewMax, NewStack};
                false ->
                    {Max, [length(SList) - 1 | StackAcc]}
            end;
        (_, {Max, StackAcc}) ->
            {Max, [length(SList) - 1 | StackAcc]}
    end, {MaxLen, Stack}, lists:seq(0, length(SList) - 1)),
    FinalMax.