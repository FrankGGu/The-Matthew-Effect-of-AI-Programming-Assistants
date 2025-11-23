-module(solution).
-export([closest_to_target/2]).

closest_to_target(Arr, Target) ->
    {_FinalAnds, FinalMinDiff} = lists:foldl(
        fun(Val, {CurrentAnds, MinDiff}) ->
            NextAnds = gb_sets:add(Val, gb_sets:new()),

            NextAndsWithPrev = gb_sets:fold(
                fun(PrevAnd, Acc) ->
                    gb_sets:add(PrevAnd band Val, Acc)
                end,
                NextAnds,
                CurrentAnds
            ),

            NewMinDiff = gb_sets:fold(
                fun(AndVal, Acc) ->
                    min(Acc, abs(AndVal - Target))
                end,
                MinDiff,
                NextAndsWithPrev
            ),

            {NextAndsWithPrev, NewMinDiff}
        end,
        {gb_sets:new(), infinity},
        Arr
    ),
    FinalMinDiff.