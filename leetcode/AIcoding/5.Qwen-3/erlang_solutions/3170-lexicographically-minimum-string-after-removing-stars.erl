-module(lexicographically_minimum_string_after_removing_stars).
-export([removeStars/1]).

removeStars(S) ->
    removeStars(S, []).

removeStars([], Stack) ->
    lists:reverse(Stack);
removeStars([H | T], Stack) ->
    if
        H == $* ->
            removeStars(T, lists:tl(Stack));
        true ->
            removeStars(T, [H | Stack])
    end.