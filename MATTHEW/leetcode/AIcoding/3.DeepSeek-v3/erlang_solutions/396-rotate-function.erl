-spec max_rotate_function(Nums :: [integer()]) -> integer().
max_rotate_function(Nums) ->
    N = length(Nums),
    Sum = lists:sum(Nums),
    F0 = lists:sum([I * lists:nth(I + 1, Nums) || I <- lists:seq(0, N - 1)]),
    rotate(Nums, N, Sum, F0, F0).

rotate(_, 1, _, _, Max) -> Max;
rotate([H|T], N, Sum, F, Max) ->
    NewF = F + Sum - N * H,
    rotate(T ++ [H], N - 1, Sum, NewF, erlang:max(NewF, Max)).