-spec min_sum_of_lengths(Arr :: [integer()], Target :: integer()) -> integer().
min_sum_of_lengths(Arr, Target) ->
    Prefix = array:from_list(Arr),
    Size = array:size(Prefix),
    PrefixSum = maps:from_list([{0, -1}]),
    {MinLen, Sum, PrefixSumMap} = lists:foldl(fun(I, {MinLenAcc, SumAcc, MapAcc}) ->
        Sum1 = SumAcc + array:get(I, Prefix),
        case maps:get(Sum1 - Target, MapAcc, none) of
            none ->
                {MinLenAcc, Sum1, maps:put(Sum1, I, MapAcc)};
            J ->
                Len = I - J,
                NewMinLen = if
                    MinLenAcc == infinity -> Len;
                    true -> min(MinLenAcc, Len)
                end,
                {NewMinLen, Sum1, maps:put(Sum1, I, MapAcc)}
        end
    end, {infinity, 0, PrefixSum}, lists:seq(0, Size - 1)),
    if
        MinLen == infinity -> -1;
        true -> MinLen
    end.

-spec min_sum_of_lengths_main(Arr :: [integer()], Target :: integer()) -> integer().
min_sum_of_lengths_main(Arr, Target) ->
    case min_sum_of_lengths(Arr, Target) of
        -1 -> -1;
        Len1 ->
            case min_sum_of_lengths(lists:reverse(Arr), Target) of
                -1 -> -1;
                Len2 -> Len1 + Len2
            end
    end.