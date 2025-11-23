-spec is_good(Array :: [integer()]) -> boolean().
is_good(Array) ->
    Sorted = lists:sort(Array),
    Max = lists:max(Sorted),
    Len = length(Sorted),
    case Len of
        Max + 1 ->
            case lists:sublist(Sorted, Max) of
                lists:seq(1, Max) ->
                    case lists:nth(Len, Sorted) of
                        Max -> true;
                        _ -> false
                    end;
                _ -> false
            end;
        _ -> false
    end.