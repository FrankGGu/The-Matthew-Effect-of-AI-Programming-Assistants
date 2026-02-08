-module(max_sum_submatrix).
-export([max_sum_submatrix/3]).

max_sum_submatrix(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MaxSum = -infinity,

    for(L <- 0, L < Cols, L + 1,
        begin
            Sums = lists:duplicate(Rows, 0),
            for(R <- L, R < Cols, R + 1,
                begin
                    for(I <- 0, I < Rows, I + 1,
                        begin
                            Sums1 = lists:nth(I,Sums),
                            Sums2 = lists:nth(I,(lists:map(fun(X) -> lists:nth(R,X) end, Matrix))),
                            Sums ! I := Sums1 + Sums2
                        end
                    ),
                    Set = gb_sets:empty(),
                    gb_sets:add_element(0, Set),
                    CurrentSum = 0,
                    for(Sum <- Sums,
                        begin
                            CurrentSum = CurrentSum + Sum,
                            Ceiling = gb_sets:smallest(gb_sets:filter(fun(X) -> X >= CurrentSum - K end, Set)),
                            if Ceiling /= undefined ->
                                    MaxSum = max(MaxSum, CurrentSum - Ceiling)
                            end,
                            Set1 = gb_sets:add_element(CurrentSum, Set),
                            Set := Set1
                        end
                    )
                end
            )
        end
    ),
    MaxSum.

-spec max(number(), number()) -> number().
max(A, B) ->
    if A > B -> A;
       true -> B
    end.

-spec infinity() -> number().
infinity() -> -1.0e308.