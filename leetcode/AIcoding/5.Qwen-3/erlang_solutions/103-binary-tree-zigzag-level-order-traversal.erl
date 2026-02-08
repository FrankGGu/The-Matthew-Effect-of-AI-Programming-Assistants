-module(binary_tree_zigzag_level_order_traversal).
-export([zigzagLevelOrder/1]).

-type tree() :: nil | {tree(), integer(), tree()}.

zigzagLevelOrder(nil) ->
    [];
zigzagLevelOrder({Left, Val, Right}) ->
    zigzagLevelOrder([ {Left, 0}, {Right, 0} ], [{Val, 0}], 0).

zigzagLevelOrder([], Acc, _) ->
    lists:reverse(Acc);
zigzagLevelOrder([{nil, _} | Rest], Acc, Level) ->
    zigzagLevelOrder(Rest, Acc, Level);
zigzagLevelOrder([{Left, L}, {Right, R} | Rest], Acc, Level) ->
    case lists:keyfind(Level, 1, Acc) of
        false ->
            NewAcc = [{Val, Level} | Acc],
            zigzagLevelOrder([ {Left, L + 1}, {Right, R + 1} | Rest ], NewAcc, Level + 1);
        {_, _} ->
            NewAcc = lists:keyreplace(Level, 1, Acc, {Val, Level}),
            zigzagLevelOrder([ {Left, L + 1}, {Right, R + 1} | Rest ], NewAcc, Level + 1)
    end.