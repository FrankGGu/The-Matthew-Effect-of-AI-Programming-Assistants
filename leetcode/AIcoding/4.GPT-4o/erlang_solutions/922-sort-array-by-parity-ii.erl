sort_array_by_parity_ii(A) ->
    Even = [X || {X, I} <- lists:zip(A, lists:seq(0, length(A)-1)), rem(X, 2) =:= 0],
    Odd = [X || {X, I} <- lists:zip(A, lists:seq(0, length(A)-1)), rem(X, 2) =:= 1],
    [if I rem 2 =:= 0 -> lists:nth((I div 2) + 1, Even); true -> lists:nth((I div 2) + 1, Odd) end || I <- lists:seq(0, length(A)-1)].