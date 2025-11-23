-module(solution).
-export([init/1, pick/2]).

init(Nums) ->
    {Nums}.

pick(Target, {Nums}) ->
    Indices = [I || {I, X} <- lists:zip(lists:seq(0, length(Nums)-1), Nums), X =:= Target],
    lists:nth(rand:uniform(length(Indices)), Indices).