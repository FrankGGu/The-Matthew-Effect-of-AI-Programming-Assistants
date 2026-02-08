-spec max_score_sightseeing_pair(A :: [integer()]) -> integer().
max_score_sightseeing_pair(A) ->
    max_score_sightseeing_pair(A, 0, 0, 1).

max_score_sightseeing_pair([_], MaxPrev, MaxTotal, _) ->
    MaxTotal;
max_score_sightseeing_pair([A, B | Rest], MaxPrev, MaxTotal, Index) ->
    Current = A + B - Index,
    NewMaxTotal = max(MaxTotal, Current),
    NewMaxPrev = max(MaxPrev, A + Index),
    max_score_sightseeing_pair([B | Rest], NewMaxPrev, NewMaxTotal, Index + 1).