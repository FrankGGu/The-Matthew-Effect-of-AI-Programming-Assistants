-spec longest_wpi(Hours :: [integer()]) -> integer().
longest_wpi(Hours) ->
    Sum = 0,
    Map = #{0 => -1},
    {MaxLen, _} = lists:foldl(fun(Hour, {Max, SumAcc}) ->
        NewSum = SumAcc + case Hour > 8 of true -> 1; false -> -1 end,
        case maps:is_key(NewSum, Map) of
            false -> maps:put(NewSum, Max, Map);
            true -> ok
        end,
        case NewSum > 0 of
            true -> {max(Max, Max + 1), NewSum};
            false ->
                case maps:find(NewSum - 1, Map) of
                    {ok, Pos} -> {max(Max, Max - Pos), NewSum};
                    error -> {Max, NewSum}
                end
        end
    end, {0, Sum}, lists:zip(lists:seq(0, length(Hours) - 1), Hours)),
    MaxLen.