-module(solution).
-export([num_valid_times/1]).

num_valid_times(Time) ->
    Count = 0,
    Hours = lists:seq(0, 23),
    Minutes = lists:seq(0, 59),
    lists:foldl(fun(H, Acc) ->
        lists:foldl(fun(M, Acc2) ->
            T = format_time(H, M),
            if
                T == Time -> Acc2 + 1;
                true -> Acc2
            end
        end, Acc, Minutes)
    end, Count, Hours).

format_time(H, M) ->
    HStr = if
        H < 10 -> "0" ++ integer_to_list(H);
        true -> integer_to_list(H)
    end,
    MStr = if
        M < 10 -> "0" ++ integer_to_list(M);
        true -> integer_to_list(M)
    end,
    HStr ++ ":" ++ MStr.