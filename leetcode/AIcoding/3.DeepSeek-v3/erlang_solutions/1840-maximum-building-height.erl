-spec max_building(N :: integer(), Restrictions :: [[integer()]]) -> integer().
max_building(N, Restrictions) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Restrictions),
    Processed = process_restrictions(Sorted, N),
    Max = calculate_max(Processed, N),
    Max.

process_restrictions(Restrictions, N) ->
    Processed = lists:foldl(fun([I, H], Acc) ->
        case Acc of
            [] -> [[I, H]];
            [[PrevI, PrevH] | Tail] ->
                NewH = min(H, PrevH + (I - PrevI)),
                [[I, NewH] | [[PrevI, PrevH] | Tail]]
        end
    end, [], Restrictions),
    lists:reverse(Processed).

calculate_max(Restrictions, N) ->
    {Max, _} = lists:foldl(fun([I, H], {CurrentMax, PrevI, PrevH}) ->
        Delta = I - PrevI,
        CurrentH = min(H, PrevH + Delta),
        NewMax = max(CurrentMax, (PrevH + CurrentH + Delta) div 2),
        {NewMax, I, CurrentH}
    end, {0, 1, 0}, Restrictions),
    LastDelta = N - case Restrictions of [] -> 1; _ -> lists:last(Restrictions) end,
    max(Max, case Restrictions of [] -> N - 1; [[_, LastH]] -> LastH + LastDelta end).