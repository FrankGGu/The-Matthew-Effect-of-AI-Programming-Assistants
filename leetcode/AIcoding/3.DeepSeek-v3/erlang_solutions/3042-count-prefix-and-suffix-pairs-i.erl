-spec count_prefix_suffix_pairs(Words :: [unicode:unicode_binary()]) -> integer().
count_prefix_suffix_pairs(Words) ->
    count_pairs(Words, 0).

count_pairs([], Count) -> Count;
count_pairs([Word | Rest], Count) ->
    NewCount = lists:foldl(fun(W, Acc) ->
        case is_prefix_and_suffix(Word, W) of
            true -> Acc + 1;
            false -> Acc
        end
    end, Count, Rest),
    count_pairs(Rest, NewCount).

is_prefix_and_suffix(Word, W) ->
    case byte_size(Word) > byte_size(W) of
        true -> false;
        false ->
            Prefix = binary:part(W, 0, byte_size(Word)),
            SuffixStart = byte_size(W) - byte_size(Word),
            Suffix = binary:part(W, SuffixStart, byte_size(Word)),
            Word =:= Prefix andalso Word =:= Suffix
    end.