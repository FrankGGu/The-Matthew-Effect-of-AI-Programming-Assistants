-spec find_smallest_integer(Nums :: [integer()], Value :: integer()) -> integer().
find_smallest_integer(Nums, Value) ->
    Counts = lists:foldl(fun(N, Acc) ->
                            Mod = N rem Value,
                            if Mod < 0 -> maps:update_with(Mod + Value, fun(V) -> V + 1 end, 1, Acc);
                               true -> maps:update_with(Mod, fun(V) -> V + 1 end, 1, Acc)
                            end
                         end, maps:new(), Nums),
    find_min_missing(0, Counts, Value).

find_min_missing(M, Counts, Value) ->
    case maps:get(M, Counts, 0) of
        0 -> M;
        Count ->
            if Count > 0 -> find_min_missing(M + 1, Counts, Value);
               true -> M
            end
    end.