-spec reverse(X :: integer()) -> integer().
reverse(X) ->
    Reversed = lists:reverse(string:tokens(integer_to_list(abs(X)), "")),
    case lists:flatten(Reversed) of
        [] -> 0;
        RevList ->
            Result = list_to_integer(RevList),
            Result =:= 0 -> 0;
            Result =:= -1 -> 0;
            true -> if
                X < 0 -> -Result;
                X > 0 -> Result;
                true -> 0
            end
    end.
