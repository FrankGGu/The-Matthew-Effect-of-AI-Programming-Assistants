-spec maximum_value(Strs :: [unicode:unicode_binary()]) -> integer().
maximum_value(Strs) ->
    lists:foldl(fun(Str, Max) ->
        case binary_to_list(Str) of
            [] -> Max;
            List ->
                case lists:all(fun(C) -> C >= $0 andalso C =< $9 end, List) of
                    true -> 
                        Num = list_to_integer(List),
                        erlang:max(Max, Num);
                    false ->
                        erlang:max(Max, length(List))
                end
        end
    end, 0, Strs).