-module(video_stitching).
-export([videoStitching/2]).

videoStitching(Clips, T) ->
  videoStitching(Clips, T, 0, 0, 0).

videoStitching([], T, CurrentEnd, Count, _) when CurrentEnd >= T ->
  Count;
videoStitching([], T, CurrentEnd, _, _) ->
  -1;

videoStitching(Clips, T, CurrentEnd, Count, PrevEnd) ->
  NextClips = [ {Start, End} || {Start, End} <- Clips, Start =< CurrentEnd, End > CurrentEnd ],
  case NextClips of
    [] ->
      if CurrentEnd =:= PrevEnd then
        -1
      else
        videoStitching(Clips, T, CurrentEnd, Count, CurrentEnd)
      end;
    _ ->
      {_, MaxEnd} = lists:max([{End, End} || {_, End} <- NextClips]),
      NewClips = [ Clip || Clip <- Clips, not lists:member(Clip, NextClips)],
      videoStitching(NewClips, T, MaxEnd, Count + 1, CurrentEnd)
  end.