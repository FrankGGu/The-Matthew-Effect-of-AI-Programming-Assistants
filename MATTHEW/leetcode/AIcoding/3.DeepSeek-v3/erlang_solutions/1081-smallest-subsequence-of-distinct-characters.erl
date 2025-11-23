-spec smallest_subsequence(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
smallest_subsequence(S) ->
    Count = maps:new(),
    Count1 = lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, Count, S),
    Stack = [],
    InStack = sets:new(),
    {Result, _} = lists:foldl(fun(Char, {StackAcc, InStackAcc}) ->
        case sets:is_element(Char, InStackAcc) of
            true ->
                Count2 = maps:update_with(Char, fun(V) -> V - 1 end, Count1),
                {StackAcc, InStackAcc, Count2};
            false ->
                NewStack = remove_greater(Char, StackAcc, InStackAcc, Count1),
                NewInStack = sets:add_element(Char, InStackAcc),
                Count2 = maps:update_with(Char, fun(V) -> V - 1 end, Count1),
                {[Char | NewStack], NewInStack, Count2}
        end
    end, {Stack, InStack, Count1}, S),
    unicode:characters_to_binary(lists:reverse(Result)).

remove_greater(Char, [H | T], InStack, Count) ->
    case H > Char andalso maps:get(H, Count) > 0 of
        true ->
            NewInStack = sets:del_element(H, InStack),
            remove_greater(Char, T, NewInStack, Count);
        false ->
            [H | T]
    end;
remove_greater(_Char, [], _InStack, _Count) ->
    [].