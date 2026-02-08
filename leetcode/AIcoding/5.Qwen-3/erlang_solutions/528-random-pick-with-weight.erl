-module(random_pick_with_weight).
-export([new/1, pick_index/1]).

new(Weights) ->
    {ok, Sum} = lists:foldl(fun(W, Acc) -> {ok, Acc + W} end, 0, Weights),
    {Weights, Sum}.

pick_index({Weights, Sum}) ->
    Rand = rand:uniform(Sum),
    pick_index(Weights, Rand, 0).

pick_index([], _, _) ->
    0;
pick_index([W | Rest], Rand, Acc) ->
    case Acc + W of
        N when N >= Rand ->
            0;
        N ->
            pick_index(Rest, Rand, N)
    end.