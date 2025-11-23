-module(shuffle_an_array).
-export([shuffle/1, reset/1]).

shuffle(Nums) ->
    Random = random:seed(os:timestamp()),
    Shuffled = lists:sort(fun(_A, _B) -> random:uniform() < 0.5 end, Nums),
    {Shuffled, Shuffled}.

reset(Nums) ->
    Nums.