-module(solution).
-export([squareful_arrays/1]).

squareful_arrays(A) ->
    TotalLength = length(A),
    InitialCounts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 0, Acc) end, #{}, A),

    UniqueNums = maps:keys(InitialCounts),

    lists:foldl(fun(StartNum, Acc) ->
        Counts = maps:update_with(StartNum, fun(V) -> V - 1 end, InitialCounts),
        Acc + dfs(StartNum, Counts, 1, TotalLength, UniqueNums)
    end, 0, UniqueNums).

dfs(LastNum, CurrentCounts, CurrentLength, TotalLength, UniqueNums) ->
    if CurrentLength == TotalLength ->
        1;
    true ->
        lists:foldl(fun(Num, Acc) ->
            case maps:get(Num, CurrentCounts, 0) of
                0 ->
                    Acc;
                _ ->
                    if is_perfect_square(LastNum + Num) ->
                        NewCounts = maps:update_with(Num, fun(V) -> V - 1 end, CurrentCounts),
                        Acc + dfs(Num, NewCounts, CurrentLength + 1, TotalLength, UniqueNums);
                    true ->
                        Acc
                    end
            end
        end, 0, UniqueNums)
    end.

is_perfect_square(N) ->
    S = round(math:sqrt(N)),
    S * S == N.