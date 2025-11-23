-spec summary_ranges(Nums :: [integer()]) -> [unicode:unicode_binary()].
summary_ranges(Nums) ->
    summary_ranges(Nums, []).

summary_ranges([], Acc) ->
    lists:reverse(Acc);
summary_ranges([H|T], Acc) ->
    {Start, End, Rest} = find_range(H, T),
    Range = 
        case Start of
            End -> integer_to_binary(Start);
            _ -> <<(integer_to_binary(Start))/binary, "->", (integer_to_binary(End))/binary>>
        end,
    summary_ranges(Rest, [Range|Acc]).

find_range(Start, []) ->
    {Start, Start, []};
find_range(Start, [Next|Rest]) when Next =:= Start + 1 ->
    find_range(Next, Rest);
find_range(Start, Rest) ->
    {Start, Start, Rest}.