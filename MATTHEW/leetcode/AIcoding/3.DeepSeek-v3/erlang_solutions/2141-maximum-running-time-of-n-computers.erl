-spec max_run_time(N :: integer(), Batteries :: [integer()]) -> integer().
max_run_time(N, Batteries) ->
    Sum = lists:sum(Batteries),
    case N > length(Batteries) of
        true -> 0;
        false ->
            Left = 1,
            Right = Sum div N,
            binary_search(N, Batteries, Left, Right)
    end.

binary_search(N, Batteries, Left, Right) ->
    if
        Left > Right -> Right;
        true ->
            Mid = Left + (Right - Left) div 2,
            case can_run(N, Batteries, Mid) of
                true -> binary_search(N, Batteries, Mid + 1, Right);
                false -> binary_search(N, Batteries, Left, Mid - 1)
            end
    end.

can_run(N, Batteries, Time) ->
    Total = lists:foldl(fun(B, Acc) -> Acc + min(B, Time) end, 0, Batteries),
    Total >= N * Time.