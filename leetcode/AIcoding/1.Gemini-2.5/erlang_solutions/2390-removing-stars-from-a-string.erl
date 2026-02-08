-module(solution).
-export([remove_stars/1]).

-spec remove_stars(S :: string()) -> string().
remove_stars(S) ->
    lists:reverse(remove_stars_acc(S, [])).

remove_stars_acc([], Acc) ->
    Acc;
remove_stars_acc([$* | T], [_ | Acc]) ->
    remove_stars_acc(T, Acc);
remove_stars_acc([$* | T], []) ->
    remove_stars_acc(T, []);
remove_stars_acc([H | T], Acc) ->
    remove_stars_acc(T, [H | Acc]).