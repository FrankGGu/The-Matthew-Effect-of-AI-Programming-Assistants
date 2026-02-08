-spec longest_subsequence(Arr :: [integer()], Difference :: integer()) -> integer().
longest_subsequence(Arr, Difference) ->
    Map = maps:new(),
    lists:foldl(fun(N, Acc) ->
        Target = N - Difference,
        case maps:get(Target, Acc, undefined) of
            undefined ->
                maps:put(N, 1, Acc);
            Len ->
                maps:put(N, Len + 1, Acc)
        end
    end, Map, Arr),
    case maps:size(Map) of
        0 -> 0;
        _ -> lists:max(maps:values(Map))
    end.