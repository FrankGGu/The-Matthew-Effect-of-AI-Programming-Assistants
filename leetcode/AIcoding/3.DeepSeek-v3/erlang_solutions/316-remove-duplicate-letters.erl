-spec remove_duplicate_letters(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_duplicate_letters(S) ->
    Count = maps:new(),
    Count1 = lists:foldl(fun(Char, Acc) -> 
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, Count, S),
    Stack = [],
    InStack = sets:new(),
    {Result, _} = lists:foldl(fun(Char, {StackAcc, InStackAcc}) ->
        Count2 = maps:update_with(Char, fun(V) -> V - 1 end, 0, Count1),
        case sets:is_element(Char, InStackAcc) of
            true -> 
                {StackAcc, InStackAcc};
            false ->
                NewStack = remove_larger_chars(StackAcc, Char, Count2, InStackAcc),
                NewInStack = sets:add_element(Char, InStackAcc),
                {[Char | NewStack], NewInStack}
        end
    end, {Stack, InStack}, S),
    lists:reverse(Result).

remove_larger_chars([], _Char, _Count, _InStack) -> [];
remove_larger_chars([Top | Rest], Char, Count, InStack) ->
    case Top > Char andalso maps:get(Top, Count) > 0 of
        true ->
            remove_larger_chars(Rest, Char, Count, sets:del_element(Top, InStack));
        false ->
            [Top | Rest]
    end.