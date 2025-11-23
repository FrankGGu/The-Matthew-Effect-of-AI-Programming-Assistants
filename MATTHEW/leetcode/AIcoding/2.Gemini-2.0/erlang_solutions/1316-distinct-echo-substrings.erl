-module(distinct_echo_substrings).
-export([solve/1]).

solve(Text) ->
  solve(Text, sets:new()).

solve(Text, Seen) ->
  Len = length(Text),
  solve(Text, 1, Len div 2, Seen).

solve(Text, Len, MaxLen, Seen) when Len > MaxLen ->
  sets:size(Seen);
solve(Text, Len, MaxLen, Seen) ->
  solve(Text, 0, length(Text) - 2 * Len + 1, Len, Seen).

solve(_Text, Start, End, _Len, Seen) when Start > End ->
  solve(_Text, _Len + 1, length(_Text) div 2, Seen);
solve(Text, Start, End, Len, Seen) ->
  Sub1 = lists:sublist(Text, Start + 1, Len),
  Sub2 = lists:sublist(Text, Start + Len + 1, Len),
  case Sub1 == Sub2 of
    true ->
      String = lists:sublist(Text, Start + 1, 2 * Len),
      case sets:is_element(String, Seen) of
        true ->
          solve(Text, Start + 1, End, Len, Seen);
        false ->
          solve(Text, Start + 1, End, Len, sets:add_element(String, Seen))
      end;
    false ->
      solve(Text, Start + 1, End, Len, Seen)
  end.