-module(solution).
-export([separate_balls/1]).

separate_balls(S) ->
    {_FinalIndex, _FinalZeroCount, TotalSwaps} = lists:foldl(
        fun(Char, {CurrentIndex, ZeroCount, AccSwaps}) ->
            case Char of
                $0 ->
                    {CurrentIndex + 1, ZeroCount + 1, AccSwaps};
                $1 ->
                    SwapsForThisOne = CurrentIndex - ZeroCount,
                    {CurrentIndex + 1, ZeroCount, AccSwaps + SwapsForThisOne}
            end
        end,
        {0, 0, 0},
        S
    ),
    TotalSwaps.