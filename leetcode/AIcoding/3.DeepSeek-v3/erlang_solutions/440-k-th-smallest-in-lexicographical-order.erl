-spec find_kth_number(N :: integer(), K :: integer()) -> integer().
find_kth_number(N, K) ->
    find_kth_number(1, K, N).

find_kth_number(Cur, 1, _N) -> Cur;
find_kth_number(Cur, K, N) ->
    Steps = count_steps(Cur, N),
    if
        Steps < K ->
            find_kth_number(Cur + 1, K - Steps, N);
        true ->
            find_kth_number(Cur * 10, K - 1, N)
    end.

count_steps(Cur, N) ->
    count_steps(Cur, Cur + 1, N, 0).

count_steps(N1, N2, N, Steps) when N1 =< N ->
    NewSteps = Steps + min(N2, N + 1) - N1,
    count_steps(N1 * 10, N2 * 10, N, NewSteps);
count_steps(_N1, _N2, _N, Steps) -> Steps.