-spec get_folder_names(Names :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
get_folder_names(Names) ->
    F = fun(Name, {Map, Acc}) ->
            case maps:get(Name, Map, 0) of
                0 ->
                    {maps:put(Name, 1, Map), [Name | Acc]};
                K ->
                    NewName = <<Name/binary, "(", (integer_to_binary(K))/binary, ")">>,
                    {maps:put(Name, K + 1, maps:put(NewName, 1, Map)), [NewName | Acc]}
            end
        end,
    {_, Result} = lists:foldl(F, {#{}, []}, Names),
    lists:reverse(Result).