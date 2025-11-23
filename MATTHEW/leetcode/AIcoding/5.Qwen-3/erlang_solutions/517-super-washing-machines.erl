-module(solve).
-export([super_washing_machines/1]).

super_washing_machines(Machines) ->
    N = length(Machines),
    Total = lists:sum(Machines),
    if
        Total rem N /= 0 -> -1;
        true ->
            Avg = Total div N,
            Max = 0,
            Acc = 0,
            lists:foldl(fun(X, AccIn) ->
                            AccOut = AccIn + X - Avg,
                            MaxVal = max(Max, abs(AccOut)),
                            {MaxVal, AccOut}
                        end, {0, 0}, Machines)
    end.