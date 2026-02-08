-spec count_good_substrings(S :: unicode:unicode_binary()) -> integer().
count_good_substrings(S) ->
    count_good_substrings(S, 0, 0).

count_good_substrings(<<A, B, C, Rest/binary>>, Index, Count) ->
    case (A =/= B) and (B =/= C) and (A =/= C) of
        true -> count_good_substrings(<<B, C, Rest/binary>>, Index + 1, Count + 1);
        false -> count_good_substrings(<<B, C, Rest/binary>>, Index + 1, Count)
    end;
count_good_substrings(_, _, Count) ->
    Count.