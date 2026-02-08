-spec min_total_cost(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
min_total_cost(Nums1, Nums2) ->
    {Swaps, Cost} = lists:foldl(fun({X, Y}, {S, C}) ->
        case X =:= Y of
            true -> {[X | S], C + X};
            false -> {S, C}
        end
    end, {[], 0}, lists:zip(Nums1, Nums2)),
    case Swaps of
        [] -> 0;
        _ ->
            Freq = lists:foldl(fun(X, Acc) ->
                maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, Swaps),
            MaxFreq = case maps:values(Freq) of
                [] -> 0;
                Vs -> lists:max(Vs)
            end,
            Total = length(Swaps),
            case 2 * MaxFreq > Total of
                true ->
                    Candidates = [K || {K, V} <- maps:to_list(Freq), V =:= MaxFreq],
                    case lists:any(fun(X) -> not lists:member(X, Nums1 ++ Nums2) end, Candidates) of
                        true -> Cost;
                        false ->
                            MinExtra = lists:min([X || X <- Nums1 ++ Nums2, not lists:member(X, Swaps)]),
                            case MinExtra of
                                infinity -> -1;
                                _ -> Cost + MinExtra
                            end
                    end;
                false -> Cost
            end
    end.