-spec is_possible(Nums :: [integer()]) -> boolean().
is_possible(Nums) ->
    Freq = maps:from_list([{X, 0} || X <- lists:seq(1, 20000)]),
    Freq1 = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, Acc) end, Freq, Nums),
    Need = maps:new(),
    lists:foldl(fun(X, _) ->
        case maps:get(X, Freq1) of
            0 -> ok;
            _ ->
                case maps:get(X, Need, 0) > 0 of
                    true ->
                        Need1 = maps:update_with(X, fun(V) -> V - 1 end, Need),
                        Need2 = maps:update_with(X + 1, fun(V) -> V + 1 end, Need1),
                        Freq2 = maps:update_with(X, fun(V) -> V - 1 end, Freq1),
                        {Need2, Freq2};
                    false ->
                        case (maps:get(X + 1, Freq1, 0) > 0) and (maps:get(X + 2, Freq1, 0) > 0) of
                            true ->
                                Freq3 = maps:update_with(X, fun(V) -> V - 1 end, Freq1),
                                Freq4 = maps:update_with(X + 1, fun(V) -> V - 1 end, Freq3),
                                Freq5 = maps:update_with(X + 2, fun(V) -> V - 1 end, Freq4),
                                Need3 = maps:update_with(X + 3, fun(V) -> V + 1 end, Need),
                                {Need3, Freq5};
                            false ->
                                {false, Freq1}
                        end
                end
        end
    end, {Need, Freq1}, Nums) =:= {Need, Freq1}.