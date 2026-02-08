-module(lexicographically_minimum_string_after_removing_stars).
-export([remove_stars/1]).

remove_stars(S) ->
  remove_stars_helper(S, []).

remove_stars_helper([], Acc) ->
  lists:reverse(Acc);
remove_stars_helper([$* | T], [_ | Acc]) ->
  remove_stars_helper(T, Acc);
remove_stars_helper([H | T], Acc) ->
  remove_stars_helper(T, [H | Acc]).