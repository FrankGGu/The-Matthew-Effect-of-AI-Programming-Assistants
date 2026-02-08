-spec odd_string(Words :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
odd_string(Words) ->
    DiffsList = lists:map(fun(Word) -> 
        Bytes = binary_to_list(Word),
        lists:map(fun({A, B}) -> B - A end, lists:zip(lists:sublist(Bytes, length(Bytes) - 1), tl(Bytes)))
    end, Words),
    {First, Second} = {hd(DiffsList), hd(tl(DiffsList))},
    case lists:member(First, tl(DiffsList)) of
        true ->
            lists:nth(lists:foldl(fun(Diffs, Index) -> 
                case Diffs =:= First of
                    false -> Index;
                    true -> Index + 1
                end
            end, 1, DiffsList) + 1, Words);
        false ->
            case lists:member(Second, tl(tl(DiffsList))) of
                true -> hd(Words);
                false -> lists:nth(2, Words)
            end
    end.