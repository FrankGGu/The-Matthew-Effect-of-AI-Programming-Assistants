-module(solution).
-export([max_run_time/2]).

max_run_time(N, Batteries) ->
    TotalBatteryCapacity = lists:sum(Batteries),
    Low = 0,
    High = TotalBatteryCapacity div N,

    BinarySearch = fun F(L, H, Ans) ->
        if 
            L > H -> Ans;
            true ->
                Mid = L + (H - L) div 2,
                if
                    check(Mid, N, Batteries) ->
                        F(Mid + 1, H, Mid);
                    true ->
                        F(L, Mid - 1, Ans)
                end
        end
    end,

    BinarySearch(Low, High, 0).

check(Time, N, Batteries) ->
    TotalAvailablePower = lists:foldl(fun(BatteryCapacity, Acc) ->
                                          Acc + min(BatteryCapacity, Time)
                                  end, 0, Batteries),

    TotalAvailablePower >= N * Time.