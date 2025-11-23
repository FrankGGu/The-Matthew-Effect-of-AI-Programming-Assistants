-module(solution).
-export([videoStitching/2]).

videoStitching(Clips, T) ->
    SortedClips = lists:sort(fun([S1,_], [S2,_]) -> S1 =< S2 end, Clips),
    stitch(T, 0, 0, SortedClips).

stitch(T, CurrentEnd, Count, _RemainingClips) when CurrentEnd >= T ->
    Count;
stitch(T, CurrentEnd, Count, RemainingClips) ->
    PrevCurrentEnd = CurrentEnd,
    {NewFarthestReach, UpdatedRemainingClips} = find_farthest_reach(RemainingClips, PrevCurrentEnd, PrevCurrentEnd),
    if
        NewFarthestReach =< PrevCurrentEnd ->
            -1;
        true ->
            stitch(T, NewFarthestReach, Count + 1, UpdatedRemainingClips)
    end.

find_farthest_reach(Clips, PrevCurrentEnd, CurrentFarthestReach) ->
    find_farthest_reach_loop(Clips, PrevCurrentEnd, CurrentFarthestReach).

find_farthest_reach_loop([], _PrevCurrentEnd, CurrentFarthestReach) ->
    {CurrentFarthestReach, []};
find_farthest_reach_loop([[Start, End] | Rest], PrevCurrentEnd, CurrentFarthestReach) ->
    if
        Start =< PrevCurrentEnd ->
            NewFarthestReach = max(CurrentFarthestReach, End),
            find_farthest_reach_loop(Rest, PrevCurrentEnd, NewFarthestReach);
        true ->
            {CurrentFarthestReach, [[Start, End] | Rest]}
    end.