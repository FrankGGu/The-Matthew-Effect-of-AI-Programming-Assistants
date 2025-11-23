-module(solution).
-export([solve/1]).

solve(Matrix) ->
    N = length(Matrix),
    case N < 2 of
        true -> false;
        false ->
            solve_helper(Matrix, N)
    end.

solve_helper(Matrix, N) ->
    lists:any(fun(I) ->
                      lists:any(fun(J) ->
                                        check_square(Matrix, N, I, J)
                                 end, lists:seq(1, N - 1))
              end, lists:seq(1, N - 1)).

check_square(Matrix, N, I, J) ->
    Color = lists:nth(I, lists:nth(J, Matrix)),
    try
        lists:nth(I, lists:nth(J + 1, Matrix)) =:= Color andalso
        lists:nth(I + 1, lists:nth(J, Matrix)) =:= Color andalso
        lists:nth(I + 1, lists:nth(J + 1, Matrix)) =:= Color
    catch
        _:_ -> false
    end.