-spec largest_combination(Candidates :: [integer()]) -> integer().
largest_combination(Candidates) ->
    MaxBits = lists:max([bit_length(C) || C <- Candidates]),
    lists:max([count_set_bits(Candidates, Bit) || Bit <- lists:seq(0, MaxBits - 1)]).

bit_length(N) when N >= 0 ->
    bit_length(N, 0).

bit_length(0, Count) -> Count;
bit_length(N, Count) ->
    bit_length(N bsr 1, Count + 1).

count_set_bits(Candidates, Bit) ->
    lists:foldl(fun(C, Acc) ->
        case (C bsr Bit) band 1 of
            1 -> Acc + 1;
            0 -> Acc
        end
    end, 0, Candidates).