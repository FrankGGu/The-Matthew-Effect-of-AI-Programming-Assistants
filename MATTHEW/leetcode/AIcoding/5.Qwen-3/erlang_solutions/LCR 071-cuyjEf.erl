-module(random_pick_with_weight).
-export([pick_random/1]).

pick_random(Weights) ->
    Total = lists:sum(Weights),
    Rand = rand:uniform(Total),
    pick_random(Weights, Rand, 0).

pick_random([], _, _) ->
    0;
pick_random([W | Rest], Target, Acc) ->
    case Acc + W of
        Sum when Sum >= Target ->
            0;
        _ ->
            pick_random(Rest, Target, Acc + W)
    end.