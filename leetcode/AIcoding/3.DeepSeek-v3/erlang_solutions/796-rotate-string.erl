-spec rotate_string(S :: unicode:unicode_binary(), Goal :: unicode:unicode_binary()) -> boolean().
rotate_string(S, Goal) ->
    case byte_size(S) =:= byte_size(Goal) of
        true -> 
            case binary:match(<<S/binary, S/binary>>, [Goal]) of
                nomatch -> false;
                _ -> true
            end;
        false -> false
    end.