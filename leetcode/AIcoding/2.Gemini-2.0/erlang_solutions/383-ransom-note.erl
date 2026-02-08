-module(ransom_note).
-export([can_construct/2]).

can_construct(RansomNote, Magazine) ->
  can_construct(string:to_lower(RansomNote), string:to_lower(Magazine), []).

can_construct([], _, _) ->
  true;
can_construct([H|T], Magazine, Counts) ->
  case lists:keyfind(H, 1, Counts) of
    false ->
      case string:chr(Magazine, H) of
        nomatch ->
          false;
        Pos ->
          NewMagazine = string:substr(Magazine, 1, Pos - 1) ++ string:substr(Magazine, Pos + 1, length(Magazine)),
          can_construct(T, NewMagazine, [{H, 1} | Counts])
      end;
    {H, Count} ->
      case Count of
        0 ->
          false;
        _ ->
          NewCounts = lists:keyreplace(H, 1, Counts, {H, Count - 1}),
          can_construct(T, Magazine, NewCounts)
      end
  end.