-spec largest_vals_from_labels(Values :: [integer()], Labels :: [integer()], NumWanted :: integer(), UseLimit :: integer()) -> integer().
largest_vals_from_labels(Values, Labels, NumWanted, UseLimit) ->
    Pairs = lists:zip(Values, Labels),
    Sorted = lists:sort(fun({V1, _}, {V2, _}) -> V1 >= V2 end, Pairs),
    Counts = maps:new(),
    {Sum, _} = lists:foldl(fun({V, L}, {Acc, N}) when N < NumWanted ->
        case maps:get(L, Counts, 0) of
            C when C < UseLimit ->
                maps:put(L, C + 1, Counts),
                {Acc + V, N + 1};
            _ ->
                {Acc, N}
        end;
        (_, AccN) -> AccN
    end, {0, 0}, Sorted),
    Sum.