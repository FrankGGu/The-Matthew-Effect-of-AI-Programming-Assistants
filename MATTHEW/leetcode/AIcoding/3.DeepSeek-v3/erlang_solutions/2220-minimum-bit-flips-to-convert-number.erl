-spec min_bit_flips(Start :: integer(), Goal :: integer()) -> integer().
min_bit_flips(Start, Goal) ->
    Xor = Start bxor Goal,
    count_ones(Xor).

count_ones(0) -> 0;
count_ones(X) ->
    (X band 1) + count_ones(X bsr 1).