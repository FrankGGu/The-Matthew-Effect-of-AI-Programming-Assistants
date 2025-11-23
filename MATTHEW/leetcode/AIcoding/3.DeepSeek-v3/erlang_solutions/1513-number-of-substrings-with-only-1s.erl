-spec num_substrings(S :: unicode:unicode_binary()) -> integer().
num_substrings(S) ->
    NumSubstrings = fun
        F(<<>>, Count, Current) -> Count + Current * (Current + 1) div 2;
        F(<<"1", Rest/binary>>, Count, Current) -> F(Rest, Count, Current + 1);
        F(<<_/binary, Rest/binary>>, Count, Current) -> F(Rest, Count + Current * (Current + 1) div 2, 0)
    end,
    NumSubstrings(S, 0, 0).