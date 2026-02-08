-module(jump_game_ii).
-export([jump/1]).

jump(Nums) ->
    jump_helper(Nums, 0, 0, 0).

jump_helper([], _CurPos, _CurRange, Jumps) ->
    Jumps;
jump_helper(Nums, CurPos, CurRange, Jumps) ->
    Len = length(Nums),
    if
        CurRange >= Len - 1 ->
            Jumps;
        true ->
            NextRange = 0,
            NextPos = CurPos,
            for(I = CurPos + 1, I =< CurRange, I + 1,
                begin
                    if
                        I + lists:nth(I + 1, Nums) > NextRange ->
                            NextRange = I + lists:nth(I + 1, Nums),
                            NextPos = I
                        ;
                        true ->
                            ok
                    end
                end),
            jump_helper(Nums, NextPos, NextRange, Jumps + 1)
    end.