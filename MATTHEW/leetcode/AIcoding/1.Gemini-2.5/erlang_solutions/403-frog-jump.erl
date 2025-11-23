-module(frog_jump).
-export([can_cross/1]).

can_cross(Stones) ->
    case Stones of
        [] -> false;
        [0] -> false;
        [H | _] when H =/= 0 -> false;
        _ ->
            LastStone = lists:last(Stones),
            JumpMap0 = lists:foldl(fun(S, Acc) -> maps:put(S, gb_sets:new(), Acc) end, #{}, Stones),
            JumpMap1 = maps:put(0, gb_sets:from_list([1]), JumpMap0),

            FinalJumpMap = lists:foldl(
                fun(CurrentStone, AccJumpMap) ->
                    CurrentJumps = maps:get(CurrentStone, AccJumpMap),
                    gb_sets:fold(
                        fun(PrevJump, InnerAccJumpMap) ->
                            PossibleNextJumps = [J || J <- [PrevJump - 1, PrevJump, PrevJump + 1], J > 0],
                            lists:foldl(
                                fun(NextJump, DeepAccJumpMap) ->
                                    NextStone = CurrentStone + NextJump,
                                    case maps:find(NextStone, DeepAccJumpMap) of
                                        {ok, OldNextStoneJumps} ->
                                            NewNextStoneJumps = gb_sets:add(NextJump, OldNextStoneJumps),
                                            maps:put(NextStone, NewNextStoneJumps, DeepAccJumpMap);
                                        error ->
                                            DeepAccJumpMap
                                    end
                                end,
                                InnerAccJumpMap,
                                PossibleNextJumps
                            )
                        end,
                        AccJumpMap,
                        CurrentJumps
                    )
                end,
                JumpMap1,
                Stones
            ),
            gb_sets:is_empty(maps:get(LastStone, FinalJumpMap)) =:= false
    end.