-module(longest_uploaded_prefix).
-export([longestUploadedPrefix/2]).

longestUploadedPrefix(N, Uploaded) ->
  longestUploadedPrefix(N, Uploaded, 0, sets:new()).

longestUploadedPrefix(N, Uploaded, Prefix, UploadedSet) ->
  case lists:member(Prefix + 1, Uploaded) of
    true ->
      NewUploadedSet = sets:add_element(Prefix + 1, UploadedSet),
      case sets:size(NewUploadedSet) of
        _ ->
          longestUploadedPrefix(N, Uploaded, Prefix + 1, NewUploadedSet)
      end;
    false ->
      Prefix
  end.