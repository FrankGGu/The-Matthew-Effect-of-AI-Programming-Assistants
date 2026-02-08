-spec count_binary_substrings(S :: unicode:unicode_binary()) -> integer().
count_binary_substrings(S) ->
    Count = 0,
    Prev = 0,
    Curr = 1,
    count_binary_substrings(S, 1, Count, Prev, Curr).

count_binary_substrings(<<>>, _Index, Count, _Prev, _Curr) ->
    Count;
count_binary_substrings(<<A, B, Rest/binary>>, Index, Count, Prev, Curr) when A =:= B ->
    count_binary_substrings(<<B, Rest/binary>>, Index + 1, Count, Prev, Curr + 1);
count_binary_substrings(<<_A, B, Rest/binary>>, Index, Count, Prev, Curr) ->
    NewCount = Count + min(Prev, Curr),
    count_binary_substrings(<<B, Rest/binary>>, Index + 1, NewCount, Curr, 1);
count_binary_substrings(<<_A>>, _Index, Count, Prev, Curr) ->
    Count + min(Prev, Curr).