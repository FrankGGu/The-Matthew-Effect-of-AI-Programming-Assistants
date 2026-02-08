-spec is_self_crossing(Distance :: [integer()]) -> boolean().
is_self_crossing(Distance) ->
    N = length(Distance),
    if
        N < 4 -> false;
        true ->
            lists:foldl(fun(I, Acc) ->
                case Acc of
                    true -> true;
                    false ->
                        if
                            I >= 3 ->
                                (lists:nth(I + 1, Distance) >= lists:nth(I - 1, Distance)) andalso
                                (lists:nth(I, Distance) >= lists:nth(I - 2, Distance));
                            I >= 4 ->
                                (lists:nth(I, Distance) >= lists:nth(I - 2, Distance) - lists:nth(I - 4, Distance)) andalso
                                (lists:nth(I - 1, Distance) =:= lists:nth(I - 3, Distance));
                            I >= 5 ->
                                (lists:nth(I - 1, Distance) >= lists:nth(I - 3, Distance) - lists:nth(I - 5, Distance)) andalso
                                (lists:nth(I - 1, Distance) =< lists:nth(I - 3, Distance)) andalso
                                (lists:nth(I, Distance) >= lists:nth(I - 2, Distance) - lists:nth(I - 4, Distance)) andalso
                                (lists:nth(I - 2, Distance) > lists:nth(I - 4, Distance));
                            true -> false
                        end
                end
            end, false, lists:seq(3, N - 1))
    end.