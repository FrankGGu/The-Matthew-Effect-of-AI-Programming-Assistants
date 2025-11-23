-module(solution).
-export([is_possible/2]).

is_possible(hand, w) ->
    hand_sorted = lists:sort(hand),
    group_size = length(hand) div w,
    is_possible(hand_sorted, group_size).

is_possible([], _) -> 
    true;
is_possible(Hand, GroupSize) ->
    {H, Rest} = lists:split(GroupSize, Hand),
    case lists:all(fun(X) -> lists:member(X + 1, Rest) end, H) of
        true -> 
            NewHand = lists:foldl(fun(X, Acc) -> lists:delete(X + 1, Acc) end, Rest, H),
            is_possible(NewHand, GroupSize);
        false -> 
            false
    end.