-spec longest_substring(S :: unicode:unicode_binary(), K :: integer()) -> integer().
longest_substring(S, K) ->
    longest_substring(S, K, 0, byte_size(S)).

longest_substring(_S, K, Start, End) when End - Start < K -> 0;
longest_substring(S, K, Start, End) ->
    Counts = count_chars(S, Start, End),
    {SplitPos, CanSplit} = find_split_pos(S, Start, End, Counts, K),
    case CanSplit of
        true ->
            Left = longest_substring(S, K, Start, SplitPos),
            Right = longest_substring(S, K, SplitPos + 1, End),
            max(Left, Right);
        false ->
            End - Start
    end.

count_chars(S, Start, End) ->
    Counts = maps:new(),
    count_chars(S, Start, End, Counts).

count_chars(S, Pos, End, Counts) when Pos < End ->
    <<_:Pos/binary, Char:8, _/binary>> = S,
    Updated = maps:update_with(Char, fun(V) -> V + 1 end, 1, Counts),
    count_chars(S, Pos + 1, End, Updated);
count_chars(_S, _Pos, _End, Counts) -> Counts.

find_split_pos(S, Start, End, Counts, K) ->
    find_split_pos(S, Start, End, Counts, K, Start).

find_split_pos(S, Pos, End, Counts, K, _) when Pos >= End -> {Pos, false};
find_split_pos(S, Pos, End, Counts, K, Start) ->
    <<_:Pos/binary, Char:8, _/binary>> = S,
    case maps:get(Char, Counts) < K of
        true -> {Pos, true};
        false -> find_split_pos(S, Pos + 1, End, Counts, K, Start)
    end.