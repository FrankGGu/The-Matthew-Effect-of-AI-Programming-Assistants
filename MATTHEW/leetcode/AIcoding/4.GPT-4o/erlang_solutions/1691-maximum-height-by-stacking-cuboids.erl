-module(solution).
-export([max_height/1]).

max_height(Cuboids) ->
    SortedCuboids = lists:map(fun({L, W, H}) -> lists:sort([L, W, H]) end, Cuboids),
    SortedCuboids1 = lists:sort(fun({A, B, C}, {D, E, F}) -> A < D orelse (A =:= D andalso (B < E orelse (B =:= E andalso C < F)) ) end, SortedCuboids),
    max_height_helper(SortedCuboids1, length(SortedCuboids1), 0, []).

max_height_helper(_, 0, Acc, _) -> Acc;
max_height_helper(Cuboids, N, Acc, Prev) ->
    {L, W, H} = lists:nth(N, Cuboids),
    NewAcc = if
        lists:all(fun({PL, PW, PH}) -> PL < L andalso PW < W end, Prev) ->
            max(Acc, H + max_height_helper(Cuboids, N - 1, 0, [Cuboids]) );
        true -> max_height_helper(Cuboids, N - 1, Acc, Prev)
    end,
    max_height_helper(Cuboids, N - 1, NewAcc, Prev).

max(X, Y) -> if X > Y -> X; true -> Y end.