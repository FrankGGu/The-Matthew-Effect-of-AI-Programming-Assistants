-spec max_occurrences(S :: unicode:unicode_binary(), MaxLetters :: integer(), MinSize :: integer(), MaxSize :: integer()) -> integer().
max_occurrences(S, MaxLetters, MinSize, MaxSize) ->
    N = byte_size(S),
    Counts = maps:new(),
    MaxOccurrences = 0,
    {_, Result} = lists:foldl(
        fun(Size, {CountsAcc, MaxAcc}) ->
            lists:foldl(
                fun(I, {InnerCounts, InnerMax}) ->
                    Sub = binary:part(S, I, Size),
                    case is_valid_substring(Sub, MaxLetters) of
                        true ->
                            NewCounts = maps:update_with(Sub, fun(V) -> V + 1 end, 1, InnerCounts),
                            NewMax = max(InnerMax, maps:get(Sub, NewCounts)),
                            {NewCounts, NewMax};
                        false ->
                            {InnerCounts, InnerMax}
                    end
                end,
                {CountsAcc, MaxAcc},
                lists:seq(0, N - Size)
        end,
        {Counts, MaxOccurrences},
        lists:seq(MinSize, min(MaxSize, N))),
    Result.

is_valid_substring(Sub, MaxLetters) ->
    UniqueLetters = sets:from_list(binary_to_list(Sub)),
    sets:size(UniqueLetters) =< MaxLetters.