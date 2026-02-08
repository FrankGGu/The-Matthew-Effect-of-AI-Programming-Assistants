-module(max_candies).
-export([max_candies/2]).

max_candies(Boxes, Keys) ->
    max_candies(Boxes, Keys, sets:new(), 0).

max_candies([], _, _, Count) ->
    Count;
max_candies([Box | Rest], Keys, Collected, Count) ->
    {Id, Candies, KeysNeeded, Contains} = Box,
    case sets:is_element(Id, Collected) of
        true ->
            max_candies(Rest, Keys, Collected, Count + Candies);
        false ->
            case lists:member(Id, Keys) of
                true ->
                    NewCollected = sets:add_element(Id, Collected),
                    NewKeys = lists:foldl(fun(K, Acc) -> lists:keepsame(K, Acc) end, Keys, KeysNeeded),
                    max_candies(Rest, NewKeys, NewCollected, Count + Candies);
                false ->
                    max_candies(Rest, Keys, Collected, Count)
            end
    end.