-module(shuffle_array).

-export([init/1, reset/1, shuffle/1]).

init(Nums) ->
    {Nums, Nums}.

reset({Original, _}) ->
    Original.

shuffle({Original, _}) ->
    Shuffled = shuffle_list(Original),
    {Original, Shuffled}.

shuffle_list(List) ->
    Random = lists:map(fun(_) -> rand:uniform() end, List),
    Zipped = lists:zip(Random, List),
    Sorted = lists:keysort(1, Zipped),
    lists:map(fun({_, X}) -> X end, Sorted).