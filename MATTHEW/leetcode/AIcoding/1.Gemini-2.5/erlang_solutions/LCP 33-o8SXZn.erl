-module(solution).
-export([trap/1]).

trap(Height) ->
    N = length(Height),
    if N < 3 -> 0;
       true ->
            LeftMax = calculate_left_max(Height),
            RightMax = calculate_right_max(Height),

            lists:foldl(
                fun({H, LM, RM}, Acc) ->
                    Water = max(0, min(LM, RM) - H),
                    Acc + Water
                end,
                0,
                lists:zip3(Height, LeftMax, RightMax)
            )
    end.

calculate_left_max_acc([], _Max, Acc) -> lists:reverse(Acc);
calculate_left_max_acc([H|T], Max, Acc) ->
    NewMax = max(H, Max),
    calculate_left_max_acc(T, NewMax, [NewMax|Acc]).

calculate_left_max(Height) ->
    calculate_left_max_acc(Height, 0, []).

calculate_right_max(Height) ->
    ReversedHeight = lists:reverse(Height),
    RightMaxReversed = calculate_left_max_acc(ReversedHeight, 0, []),
    lists:reverse(RightMaxReversed).