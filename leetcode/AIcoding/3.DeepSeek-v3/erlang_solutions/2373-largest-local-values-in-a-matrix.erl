-spec largest_local(Matrix :: [[integer()]]) -> [[integer()]].
largest_local(Matrix) ->
    N = length(Matrix),
    Result = [[ max_in_3x3(Matrix, I, J) || J <- lists:seq(1, N - 2) ] || I <- lists:seq(1, N - 2)],
    Result.

max_in_3x3(Matrix, I, J) ->
    SubMatrix = [lists:sublist(Row, J, 3) || Row <- lists:sublist(Matrix, I, 3)],
    lists:max(lists:flatten(SubMatrix)).