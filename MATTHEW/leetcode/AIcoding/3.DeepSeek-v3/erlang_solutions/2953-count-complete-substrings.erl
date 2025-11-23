-spec count_complete_substrings(Word :: unicode:unicode_binary(), K :: integer()) -> integer().
count_complete_substrings(Word, K) ->
    Len = byte_size(Word),
    lists:sum([count_substrings(Word, K, I) || I <- lists:seq(1, 26), K * I =< Len]).

count_substrings(Word, K, Unique) ->
    Len = byte_size(Word),
    Count = 0,
    lists:foldl(fun(Start, Acc) ->
        End = Start + K * Unique - 1,
        case End > Len of
            true -> Acc;
            false ->
                Sub = binary:part(Word, Start - 1, K * Unique),
                case is_complete(Sub, K, Unique) of
                    true -> Acc + 1;
                    false -> Acc
                end
        end
    end, 0, lists:seq(1, Len - K * Unique + 1)).

is_complete(Sub, K, Unique) ->
    Counts = maps:new(),
    Counts1 = lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, Counts, binary_to_list(Sub)),
    case maps:size(Counts1) of
        Unique ->
            lists:all(fun({_, V}) -> V =:= K end, maps:to_list(Counts1));
        _ -> false
    end.