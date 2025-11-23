-spec slowest_key(ReleaseTimes :: [integer()], KeysPressed :: unicode:unicode_binary()) -> char().
slowest_key(ReleaseTimes, KeysPressed) ->
    {MaxDuration, MaxKey} = lists:foldl(
        fun(I, {PrevTime, {CurrentMax, CurrentKey}}) ->
            Time = lists:nth(I, ReleaseTimes),
            Duration = Time - PrevTime,
            Key = binary:at(KeysPressed, I - 1),
            if
                Duration > CurrentMax -> {Time, {Duration, Key}};
                Duration =:= CurrentMax andalso Key > CurrentKey -> {Time, {Duration, Key}};
                true -> {Time, {CurrentMax, CurrentKey}}
            end
        end,
        {0, {0, 0}},
        lists:seq(1, length(ReleaseTimes))
    ),
    MaxKey.