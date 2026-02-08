-module(solution).
-export([highest_altitude/1]).

highest_altitude(GainList) ->
    {_FinalAltitude, MaxAltitude} = lists:foldl(
        fun(Gain, {CurrentAlt, MaxAlt}) ->
            NewCurrentAlt = CurrentAlt + Gain,
            NewMaxAlt = max(MaxAlt, NewCurrentAlt),
            {NewCurrentAlt, NewMaxAlt}
        end,
        {0, 0},
        GainList
    ),
    MaxAltitude.