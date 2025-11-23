-spec longest_awesome(S :: unicode:unicode_binary()) -> integer().
longest_awesome(S) ->
    Str = binary_to_list(S),
    Prefix = #{0 => -1},
    MaxLen = 0,
    Mask = 0,
    {MaxLen, _} = lists:foldl(fun(Char, {Max, AccMask, AccPrefix}) ->
        Index = Char - $0,
        NewMask = AccMask bxor (1 bsl Index),
        case maps:get(NewMask, AccPrefix, none) of
            none ->
                {Max, NewMask, maps:put(NewMask, Index, AccPrefix)};
            Pos ->
                {max(Max, Index - Pos), NewMask, AccPrefix}
        end
    end, {MaxLen, Mask, Prefix}, lists:zip(lists:seq(0, length(Str) - 1), Str)),
    MaxLen.