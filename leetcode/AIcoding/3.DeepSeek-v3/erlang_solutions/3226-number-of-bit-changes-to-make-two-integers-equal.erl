-spec bit_changes(X :: integer(), Y :: integer()) -> integer().
bit_changes(X, Y) ->
    Z = X bxor Y,
    count_ones(Z).

count_ones(0) -> 0;
count_ones(Z) -> 
    (Z band 1) + count_ones(Z bsr 1).