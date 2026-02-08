-module(solution).
-export([maximum_difference/1]).

maximum_difference([H|T]) ->
    {_MinElement, MaxDiff} = lists:foldl(
        fun(CurrentElement, {MinElementAcc, MaxDiffAcc}) ->
            NewMinElement = min(MinElementAcc, CurrentElement),
            NewMaxDiff =
                if CurrentElement > MinElementAcc ->
                       max(MaxDiffAcc, CurrentElement - MinElementAcc);
                   true ->
                       MaxDiffAcc
                end,
            {NewMinElement, NewMaxDiff}
        end,
        {H, -1},
        T
    ),
    MaxDiff.