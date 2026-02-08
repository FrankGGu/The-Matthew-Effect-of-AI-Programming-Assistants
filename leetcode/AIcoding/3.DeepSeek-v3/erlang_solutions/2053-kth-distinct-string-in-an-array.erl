-spec kth_distinct(Arr :: [unicode:unicode_binary()], K :: integer()) -> unicode:unicode_binary().
kth_distinct(Arr, K) ->
    Counts = lists:foldl(fun(S, Acc) -> maps:update_with(S, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),
    Distinct = lists:filter(fun(S) -> maps:get(S, Counts) =:= 1 end, Arr),
    case length(Distinct) >= K of
        true -> lists:nth(K, Distinct);
        false -> <<>>
    end.