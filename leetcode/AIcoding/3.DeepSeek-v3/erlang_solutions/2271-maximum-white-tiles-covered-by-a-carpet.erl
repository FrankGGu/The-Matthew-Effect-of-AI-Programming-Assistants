-spec maximum_white_tiles(Tiles :: [[integer()]], CarpetLen :: integer()) -> integer().
maximum_white_tiles(Tiles, CarpetLen) ->
    SortedTiles = lists:sort(fun([A, _], [B, _]) -> A =< B end, Tiles),
    {MaxCovered, _, _} = 
        lists:foldl(
            fun([Start, End], {Max, PrefixSum, Queue}) ->
                NewPrefixSum = PrefixSum + (End - Start + 1),
                NewQueue = [{Start, End} | Queue],
                {TrimmedQueue, TrimmedPrefix} = trim_queue(NewQueue, Start + CarpetLen - 1, NewPrefixSum),
                CurrentCover = calculate_cover(TrimmedQueue, Start + CarpetLen - 1, TrimmedPrefix),
                {max(Max, CurrentCover), TrimmedPrefix, TrimmedQueue}
            end,
            {0, 0, []},
            SortedTiles
        ),
    MaxCovered.

trim_queue(Queue, Limit, PrefixSum) ->
    case Queue of
        [{Start, End} | Rest] when End >= Limit ->
            Overlap = min(End, Limit) - max(Start, Limit - CarpetLen + 1) + 1,
            {[{max(Start, Limit - CarpetLen + 1), min(End, Limit)} | Rest], PrefixSum - (End - Start + 1) + Overlap};
        [_ | Rest] ->
            trim_queue(Rest, Limit, PrefixSum - (End - Start + 1));
        [] ->
            {[], 0}
    end.

calculate_cover([], _, PrefixSum) -> PrefixSum;
calculate_cover([{Start, End} | Rest], Limit, PrefixSum) ->
    Overlap = min(End, Limit) - max(Start, Limit - CarpetLen + 1) + 1,
    PrefixSum + Overlap.