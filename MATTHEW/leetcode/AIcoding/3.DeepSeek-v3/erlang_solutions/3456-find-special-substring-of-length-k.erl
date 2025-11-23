-spec find_special_substring(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
find_special_substring(S, K) ->
    Bin = unicode:characters_to_binary(S),
    Size = byte_size(Bin),
    if 
        K > Size -> <<>>;
        true -> 
            find_substring(Bin, K, 0, Size - K, <<>>, 0)
    end.

find_substring(_Bin, _K, Index, MaxIndex, Best, BestCount) when Index > MaxIndex ->
    Best;
find_substring(Bin, K, Index, MaxIndex, Best, BestCount) ->
    Sub = binary:part(Bin, Index, K),
    Count = count_unique(Sub, 0, K, #{}),
    if
        Count > BestCount ->
            find_substring(Bin, K, Index + 1, MaxIndex, Sub, Count);
        true ->
            find_substring(Bin, K, Index + 1, MaxIndex, Best, BestCount)
    end.

count_unique(_Sub, Pos, K, Map) when Pos >= K ->
    maps:size(Map);
count_unique(Sub, Pos, K, Map) ->
    Char = binary:at(Sub, Pos),
    case maps:is_key(Char, Map) of
        true -> count_unique(Sub, Pos + 1, K, Map);
        false -> count_unique(Sub, Pos + 1, K, Map#{Char => true})
    end.