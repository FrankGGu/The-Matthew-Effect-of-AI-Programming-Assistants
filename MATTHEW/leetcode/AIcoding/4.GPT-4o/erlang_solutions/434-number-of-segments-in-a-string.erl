-spec count_segments(S :: unicode:unicode_binary()) -> integer().
count_segments(S) ->
    Words = binary:split(S, <<" ">>, [global]),
    Filtered = [W || W <- Words, W =/= <<>>],
    length(Filtered).
