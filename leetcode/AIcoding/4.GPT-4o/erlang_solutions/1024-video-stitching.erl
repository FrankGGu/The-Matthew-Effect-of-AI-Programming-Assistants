-module(solution).
-export([video_stitching/2]).

video_stitching(Clips, T) ->
    SortedClips = lists:sort(fun({S1, E1}, {S2, E2}) -> S1 < S2 end, Clips),
    video_stitching_helper(SortedClips, T, 0, 0, 0).

video_stitching_helper([], T, _, _, Result) ->
    if
        T > 0 -> -1;
        true -> Result
    end;
video_stitching_helper([{S, E} | Rest], T, MaxEnd, CurrentEnd, Result) ->
    case S > MaxEnd of
        true -> 
            if
                CurrentEnd >= T -> Result;
                S > CurrentEnd -> -1;
                true -> 
                    video_stitching_helper(Rest, T, MaxEnd, CurrentEnd, Result + 1)
            end;
        false -> 
            NewMaxEnd = max(MaxEnd, E),
            video_stitching_helper(Rest, T, NewMaxEnd, CurrentEnd, Result)
    end.