-module(reorganize_string).
-export([reorganize_string/1]).

reorganize_string(S) ->
  reorganize_string(S, []).

reorganize_string("", Acc) ->
  lists:reverse(Acc);
reorganize_string(S, Acc) ->
  {MaxChar, Count} = find_max_char(S),
  if
    Count > (length(S) + 1) div 2 ->
      "";
    true ->
      NewS = string:replace(S, MaxChar, "", all),
      reorganize_string(NewS, [MaxChar | Acc])
  end.

find_max_char(S) ->
  Counts = lists:foldl(fun(C, Acc) ->
                           maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, string:to_list(S)),
  lists:foldl(fun({Char, Count}, {MaxChar, MaxCount}) ->
                  if
                    Count > MaxCount ->
                      {Char, Count};
                    true ->
                      {MaxChar, MaxCount}
                  end
              end, {undefined, 0}, maps:to_list(Counts)).