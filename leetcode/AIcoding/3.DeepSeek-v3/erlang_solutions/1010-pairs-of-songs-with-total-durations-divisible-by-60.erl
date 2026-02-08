-spec num_pairs_divisible_by60(Durations :: [integer()]) -> integer().
num_pairs_divisible_by60(Durations) ->
    Counts = lists:foldl(fun(Dur, Acc) ->
        Rem = Dur rem 60,
        maps:update_with(Rem, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Durations),
    lists:foldl(fun(Rem, Acc) ->
        case Rem of
            0 -> 
                V = maps:get(0, Counts, 0),
                Acc + V * (V - 1) div 2;
            30 -> 
                V = maps:get(30, Counts, 0),
                Acc + V * (V - 1) div 2;
            _ when Rem < 30 ->
                V1 = maps:get(Rem, Counts, 0),
                V2 = maps:get(60 - Rem, Counts, 0),
                Acc + V1 * V2;
            _ -> 
                Acc
        end
    end, 0, maps:keys(Counts)).