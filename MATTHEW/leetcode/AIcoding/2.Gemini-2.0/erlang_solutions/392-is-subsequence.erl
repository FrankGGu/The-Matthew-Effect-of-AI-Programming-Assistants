-module(is_subsequence).
-export([is_subsequence/2]).

is_subsequence(S, T) ->
  is_subsequence_helper(S, T, 0, 0).

is_subsequence_helper([], _, _, _) ->
  true;
is_subsequence_helper(_, [], _, _) ->
  false;
is_subsequence_helper([SHead | STail], [THead | TTail], SIndex, TIndex) ->
  if
    SHead == THead ->
      is_subsequence_helper(STail, TTail, SIndex + 1, TIndex + 1);
    true ->
      is_subsequence_helper([SHead | STail], TTail, SIndex, TIndex + 1)
  end.