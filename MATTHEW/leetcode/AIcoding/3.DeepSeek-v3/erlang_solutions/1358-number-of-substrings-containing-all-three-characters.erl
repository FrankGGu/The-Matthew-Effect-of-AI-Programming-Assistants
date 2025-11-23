-spec count_substrings(S :: unicode:unicode_binary()) -> integer().
count_substrings(S) ->
    count_substrings(S, 0, 0, #{}, 0).

count_substrings(<<>>, _Left, _Right, _Counts, Total) ->
    Total;
count_substrings(<<C:8, Rest/binary>>, Left, Right, Counts, Total) ->
    NewCounts = maps:update_with(C, fun(V) -> V + 1 end, 1, Counts),
    NewRight = Right + 1,
    {NewLeft, NewCounts1} = adjust_window(Left, NewRight, NewCounts, S),
    NewTotal = Total + NewLeft,
    count_substrings(Rest, NewLeft, NewRight, NewCounts1, NewTotal).

adjust_window(Left, Right, Counts, S) ->
    case maps:size(Counts) =:= 3 of
        true ->
            case maps:size(Counts) =:= 3 of
                true ->
                    <<_:Left/binary, C:8, _/binary>> = S,
                    NewCounts = case maps:get(C, Counts) of
                        1 -> maps:remove(C, Counts);
                        V -> maps:put(C, V - 1, Counts)
                    end,
                    adjust_window(Left + 1, Right, NewCounts, S);
                false ->
                    {Left, Counts}
            end;
        false ->
            {Left, Counts}
    end.