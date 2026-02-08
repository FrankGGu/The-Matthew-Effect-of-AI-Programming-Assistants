-module(remove_stars).
-export([remove_stars/1]).

remove_stars(S) ->
  remove_stars_helper(S, []).

remove_stars_helper([], Acc) ->
  lists:reverse(Acc);
remove_stars_helper([$* | T], Acc) ->
  case Acc of
    [] -> remove_stars_helper(T, []);
    [_ | Rest] -> remove_stars_helper(T, Rest)
  end;
remove_stars_helper([H | T], Acc) ->
  remove_stars_helper(T, [H | Acc]).