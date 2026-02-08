-spec longer_ones_than_zeros(S :: unicode:unicode_binary()) -> boolean().
longer_ones_than_zeros(S) ->
    Bin = binary_to_list(S),
    {MaxOnes, MaxZeros} = lists:foldl(fun
        ($1, {Ones, Zeros, CurrentOnes, CurrentZeros}) ->
            NewCurrentOnes = CurrentOnes + 1,
            NewMaxOnes = max(Ones, NewCurrentOnes),
            {NewMaxOnes, Zeros, NewCurrentOnes, 0};
        ($0, {Ones, Zeros, CurrentOnes, CurrentZeros}) ->
            NewCurrentZeros = CurrentZeros + 1,
            NewMaxZeros = max(Zeros, NewCurrentZeros),
            {Ones, NewMaxZeros, 0, NewCurrentZeros}
    end, {0, 0, 0, 0}, Bin),
    MaxOnes > MaxZeros.