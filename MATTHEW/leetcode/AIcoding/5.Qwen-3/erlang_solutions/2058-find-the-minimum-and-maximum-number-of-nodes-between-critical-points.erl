-module(solution).
-export([nodesBetweenCriticalPoints/1]).

nodesBetweenCriticalPoints(Head) ->
    {Min, Max} = find_min_max(Head, [], 0),
    case Min of
        infinity -> [-1, -1];
        _ -> [Min, Max]
    end.

find_min_max(null, Acc, _) ->
    {infinity, 0};
find_min_max({Val, Next}, Acc, Index) ->
    case Acc of
        [] ->
            find_min_max(Next, [{Val, Index}], Index + 1);
        [{PrevVal, PrevIndex} | _] ->
            if
                (PrevVal > Val andalso Val < next_val(Next)) orelse
                (PrevVal < Val andalso Val > next_val(Next)) ->
                    CriticalIndex = Index,
                    MinDist = CriticalIndex - PrevIndex,
                    MaxDist = CriticalIndex - lists:last(Acc) -- 1,
                    NewAcc = Acc ++ [{Val, Index}],
                    {Min, Max} = find_min_max(Next, NewAcc, Index + 1),
                    {min(Min, MinDist), max(Max, MaxDist)};
                true ->
                    find_min_max(Next, Acc ++ [{Val, Index}], Index + 1)
            end
    end.

next_val(null) -> 0;
next_val({Val, _}) -> Val.