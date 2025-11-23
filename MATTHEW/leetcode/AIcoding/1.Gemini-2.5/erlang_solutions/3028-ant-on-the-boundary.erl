-module(solution).
-export([ant_on_the_boundary/1]).

ant_on_the_boundary(Steps) ->
    {_FinalPosition, ZeroCount} = lists:foldl(
        fun(Step, {CurrentPosition, CurrentZeroCount}) ->
            NewPosition = CurrentPosition + Step,
            NewZeroCount = if
                               NewPosition == 0 -> CurrentZeroCount + 1;
                               true -> CurrentZeroCount
                           end,
            {NewPosition, NewZeroCount}
        end,
        {0, 0},
        Steps
    ),
    ZeroCount.