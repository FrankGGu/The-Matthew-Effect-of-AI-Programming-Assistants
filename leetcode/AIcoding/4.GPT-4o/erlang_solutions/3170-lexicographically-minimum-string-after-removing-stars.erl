-module(solution).
-export([remove_stars/1]).

remove_stars(S) ->
    remove_stars(S, []).

remove_stars([], Acc) ->
    lists:reverse(Acc);
remove_stars([Star | Rest], Acc) when Star =:= $* ->
    remove_stars(Rest, tl(Acc));
remove_stars([Char | Rest], Acc) ->
    remove_stars(Rest, [Char | Acc]).