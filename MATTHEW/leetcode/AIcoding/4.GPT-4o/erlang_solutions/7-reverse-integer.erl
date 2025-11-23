-spec reverse(X :: integer()) -> integer().
reverse(X) ->
    Result = lists:reverse(string:chars(integer_to_list(abs(X)))),
    case length(Result) > 0 of
        true ->
            Reversed = list_to_integer(Result),
            case X < 0 of
                true -> 
                    Reversed =:= 0 -> 0;
                    Reversed =:= 0 -> 0;
                    _ -> -Reversed;
            end;
        false -> 0
    end.
