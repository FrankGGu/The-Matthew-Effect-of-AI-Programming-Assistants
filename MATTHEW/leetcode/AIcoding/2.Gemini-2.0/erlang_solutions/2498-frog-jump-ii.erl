-module(frog_jump_ii).
-export([min_max_gap/1]).

min_max_gap(Stones) ->
  lists:foldl(fun(Stone, {MaxGap, LastStone}) ->
                  Gap1 = abs(Stone - LastStone),
                  Gap2 = abs(Stones hd - Stone),
                  MaxGapNew = max(MaxGap, max(Gap1, Gap2)),
                  {MaxGapNew, Stone}
              end, {0, Stones hd}, tl(Stones))
  .