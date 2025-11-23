-super_washing_machines(Machines) ->
    Total = lists:sum(Machines),
    N = length(Machines),
    case Total rem N of
        0 ->
            Avg = Total div N,
            {Ans, _, _} = lists:foldl(fun(M, {Res, Balance, Sum}) ->
                Balance1 = Balance + M - Avg,
                Res1 = max(Res, max(abs(Balance1), M - Avg)),
                {Res1, Balance1, Sum + M}
            end, {0, 0, 0}, Machines),
            Ans;
        _ ->
            -1
    end.