-spec most_frequent_key(List :: [integer()], Key :: integer()) -> integer().
most_frequent_key(List, Key) ->
    {Freq, _} = lists:foldl(fun
        (X, {F, Prev}) when Prev =:= Key ->
            NewF = maps:update_with(X, fun(V) -> V + 1 end, 1, F),
            {NewF, X};
        (X, {F, _}) ->
            {F, X}
    end, {#{}, undefined}, List),
    case maps:size(Freq) of
        0 -> -1;
        _ -> 
            {MaxKey, _} = lists:foldl(fun
                (K, {_, MaxV} = Acc) ->
                    V = maps:get(K, Freq),
                    case V > MaxV of
                        true -> {K, V};
                        false -> Acc
                    end;
                (K, none) ->
                    {K, maps:get(K, Freq)}
            end, none, maps:keys(Freq)),
            MaxKey
    end.