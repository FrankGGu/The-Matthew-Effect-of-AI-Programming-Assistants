-spec video_stitching(Clips :: [[integer()]], Time :: integer()) -> integer().
video_stitching(Clips, Time) ->
    SortedClips = lists:sort(fun([A, _], [B, _]) -> A =< B end, Clips),
    video_stitching(SortedClips, Time, 0, 0, 0).

video_stitching(_, Time, CurrentEnd, _, Count) when CurrentEnd >= Time ->
    Count;
video_stitching([], _, CurrentEnd, _, _) when CurrentEnd < Time ->
    -1;
video_stitching([[Start, End] | Rest], Time, CurrentEnd, NextEnd, Count) when Start =< CurrentEnd ->
    if
        End > NextEnd ->
            video_stitching(Rest, Time, CurrentEnd, End, Count);
        true ->
            video_stitching(Rest, Time, CurrentEnd, NextEnd, Count)
    end;
video_stitching([[Start, _] | _], Time, CurrentEnd, _, _) when Start > CurrentEnd, CurrentEnd < Time ->
    -1;
video_stitching(Clips, Time, CurrentEnd, NextEnd, Count) ->
    video_stitching(Clips, Time, NextEnd, NextEnd, Count + 1).