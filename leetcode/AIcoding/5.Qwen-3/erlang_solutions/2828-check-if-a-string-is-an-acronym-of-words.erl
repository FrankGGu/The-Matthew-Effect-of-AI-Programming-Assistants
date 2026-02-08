-module(solution).
-export([is_acronym/2]).

is_acronym(Words, A) ->
    Acronym = lists:foldl(fun(W, Acc) -> Acc ++ [hd(W)] end, [], Words),
    lists:equal(Acronym, A).