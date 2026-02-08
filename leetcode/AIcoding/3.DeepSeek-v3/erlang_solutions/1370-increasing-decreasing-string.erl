-spec sort_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
sort_string(S) ->
    List = lists:sort(binary_to_list(S)),
    sort_string(List, [], []).

sort_string([], [], Acc) ->
    list_to_binary(lists:reverse(Acc));
sort_string([], Temp, Acc) ->
    sort_string(lists:reverse(Temp), [], Acc);
sort_string([H | T], Temp, Acc) ->
    case Acc of
        [] ->
            sort_string(T, Temp, [H | Acc]);
        [Prev | _] when H > Prev ->
            sort_string(T, Temp, [H | Acc]);
        _ ->
            sort_string(T, [H | Temp], Acc)
    end.