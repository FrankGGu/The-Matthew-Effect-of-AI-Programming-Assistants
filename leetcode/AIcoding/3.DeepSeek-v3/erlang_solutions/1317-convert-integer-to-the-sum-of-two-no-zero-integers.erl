-spec get_no_zero_integers(N :: integer()) -> [integer()].
get_no_zero_integers(N) ->
    lists:last([ [A, B] || A <- lists:seq(1, N-1), B <- [N - A], not has_zero(A), not has_zero(B) ]).

has_zero(N) ->
    lists:member($0, integer_to_list(N)).