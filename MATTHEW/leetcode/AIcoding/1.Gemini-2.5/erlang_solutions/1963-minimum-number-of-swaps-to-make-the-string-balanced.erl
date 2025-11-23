-module(solution).
-export([minSwaps/1]).

minSwaps(S) ->
    {_OpenCount, UnmatchedCloseCount} = lists:foldl(
        fun(Char, {Open, UnmatchedClose}) ->
            case Char of
                $[ -> {Open + 1, UnmatchedClose};
                $] ->
                    if
                        Open > 0 -> {Open - 1, UnmatchedClose};
                        true -> {Open, UnmatchedClose + 1}
                    end
            end
        end,
        {0, 0},
        S
    ),
    (UnmatchedCloseCount + 1) div 2.