-module(jewels_and_stones).
-export([num_jewelsInStones/2]).

num_jewelsInStones(Jewels, Stones) ->
    JSet = sets:from_list(Jewels),
    count(JSet, Stones, 0).

count(_, [], Acc) ->
    Acc;
count(JSet, [H|T], Acc) ->
    case sets:is_element(H, JSet) of
        true -> count(JSet, T, Acc + 1);
        false -> count(JSet, T, Acc)
    end.