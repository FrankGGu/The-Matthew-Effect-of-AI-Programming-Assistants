-spec longest_continuous_substring(S :: unicode:unicode_binary()) -> integer().
longest_continuous_substring(S) ->
    case S of
        <<>> -> 0;
        _ ->
            Bin = unicode:characters_to_list(S),
            longest(Bin, 1, 1, 1)
    end.

longest([], _, _, Max) -> Max;
longest([_], _, Curr, Max) -> max(Curr, Max);
longest([A, B | Rest], Prev, Curr, Max) ->
    if
        B - A == 1 ->
            NewCurr = Curr + 1,
            longest([B | Rest], B, NewCurr, max(NewCurr, Max));
        true ->
            longest([B | Rest], B, 1, max(Curr, Max))
    end.