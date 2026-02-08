-module(jump_game_ii).
-export([jump/1]).

jump(Numbers) ->
    jump(Numbers, 0, 0, 0).

jump([], _, _, Acc) ->
    Acc;
jump([H|T], Index, Farthest, Steps) ->
    if
        Index > Farthest ->
            false;
        true ->
            NewFarthest = max(Farthest, Index + H),
            if
                Index == length(Numbers) - 1 ->
                    Steps;
                Index == Farthest ->
                    jump(T, Index + 1, NewFarthest, Steps + 1);
                true ->
                    jump(T, Index + 1, NewFarthest, Steps)
            end
    end.