-module(solution).
-export([judgePoint24/1]).

-define(EPSILON, 0.001).

judgePoint24(Nums) ->
    Floats = [float(N) || N <- Nums],
    can_reach_24(Floats).

can_reach_24(Numbers) when length(Numbers) == 1 ->
    abs(hd(Numbers) - 24.0) < ?EPSILON;
can_reach_24(Numbers) ->
    lists:any(fun({A, B, Rest}) ->
        can_reach_24([A + B | Rest]) orelse
        can_reach_24([A - B | Rest]) orelse
        can_reach_24([B - A | Rest]) orelse
        can_reach_24([A * B | Rest]) orelse
        (B =/= 0.0 andalso can_reach_24([A / B | Rest])) orelse
        (A =/= 0.0 andalso can_reach_24([B / A | Rest]))
    end, generate_pairs(Numbers)).

generate_pairs(List) ->
    Len = length(List),
    IndexedList = lists:zip(lists:seq(0, Len - 1), List),
    [ {X, Y, Remaining} ||
        {I, X} <- IndexedList,
        {J, Y} <- IndexedList,
        I < J,
        Remaining = [Z || {K, Z} <- IndexedList, K =/= I, K =/= J]
    ].