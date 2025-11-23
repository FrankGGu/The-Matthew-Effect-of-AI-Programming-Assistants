-module(remove_stars_from_string).
-export([removeStars/1]).

removeStars(S) ->
    removeStars(S, []).

removeStars([], Acc) ->
    lists:reverse(Acc);
removeStars([H | T], Acc) ->
    if
        H == $* ->
            removeStars(T, tl(Acc));
        true ->
            removeStars(T, [H | Acc])
    end.