-module(video_stitching).
-export([video_stitching/2]).

video_stitching(Paths, T) ->
    lists:sort(Paths),
    video_stitching(Paths, T, 0, 0, []).

video_stitching([], _, _, _, Acc) ->
    case lists:all(fun({Start, End}) -> End >= T end, Acc) of
        true -> length(Acc);
        false -> -1
    end;

video_stitching([H | T], Target, CurrentEnd, Count, Acc) ->
    {Start, End} = H,
    if Start > CurrentEnd ->
        video_stitching(T, Target, CurrentEnd, Count, Acc);
       true ->
            NewAcc = [{Start, End} | Acc],
            NewCurrentEnd = max(CurrentEnd, End),
            if NewCurrentEnd >= Target ->
                Count + 1;
               true ->
                    video_stitching(T, Target, NewCurrentEnd, Count + 1, NewAcc)
            end
    end.