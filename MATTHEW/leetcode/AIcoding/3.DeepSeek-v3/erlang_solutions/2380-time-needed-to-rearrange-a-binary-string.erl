-spec seconds_to_remove_occurrences(S :: unicode:unicode_binary()) -> integer().
seconds_to_remove_occurrences(S) ->
    seconds_to_remove_occurrences(binary_to_list(S), 0).

seconds_to_remove_occurrences(S, Time) ->
    case lists:splitwith(fun(C) -> C =/= $1 end, S) of
        {Prefix, []} -> Time;
        {Prefix, [$1 | Rest]} ->
            case lists:splitwith(fun(C) -> C =/= $0 end, Rest) of
                {_, []} -> Time;
                {Middle, [$0 | Suffix]} ->
                    NewS = Prefix ++ Middle ++ "10" ++ Suffix,
                    seconds_to_remove_occurrences(NewS, Time + 1)
            end
    end.