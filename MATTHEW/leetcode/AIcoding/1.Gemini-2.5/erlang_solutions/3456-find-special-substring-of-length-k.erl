-module(solution).
-export([solve/2]).

solve(S, K) ->
    solve_internal(string:to_list(S), K, 0, 0, 0).

solve_internal([], K, _CurrentChar, CurrentLength, MaxOverallLength) ->
    FinalMax = if
        CurrentLength >= K ->
            max(MaxOverallLength, CurrentLength);
        true ->
            MaxOverallLength
    end,
    if
        FinalMax == 0 -> -1;
        true -> FinalMax
    end;
solve_internal([H|T], K, CurrentChar, CurrentLength, MaxOverallLength) ->
    if
        H == CurrentChar ->
            solve_internal(T, K, H, CurrentLength + 1, MaxOverallLength);
        true ->
            UpdatedMaxOverallLength = if
                CurrentLength >= K ->
                    max(MaxOverallLength, CurrentLength);
                true ->
                    MaxOverallLength
            end,
            solve_internal(T, K, H, 1, UpdatedMaxOverallLength)
    end.