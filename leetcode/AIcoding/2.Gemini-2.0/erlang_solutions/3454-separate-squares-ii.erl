-module(separate_squares_ii).
-export([solve/1]).

solve(n) ->
    solve(n, 1, 1, []).

solve(0, _, _, Acc) ->
    lists:reverse(Acc);
solve(N, A, B, Acc) when A * A > N ->
    [];
solve(N, A, B, Acc) ->
    SA = A * A,
    SB = B * B,
    case N - SA of
        0 ->
            solve(0, A + 1, 1, [A | Acc]);
        Res when Res > 0 ->
            case is_square(Res) of
                true ->
                    solve(0, A + 1, 1, [A | Acc]);
                false ->
                    solve(N, A + 1, 1, Acc)
            end;
        _ ->
            solve(N, A + 1, 1, Acc)
    end.

is_square(N) ->
    Sqrt = math:sqrt(N),
    floor(Sqrt) == Sqrt.