-module(solution).
-export([max_unique_splits/1]).

max_unique_splits(S) ->
    solve(S, sets:new()).

solve(S, Seen) ->
    if
        byte_size(S) == 0 ->
            sets:size(Seen);
        true ->
            StringLen = byte_size(S),
            solve_loop(S, 1, StringLen, Seen, 0)
    end.

solve_loop(_OriginalString, CurrentSubstrLen, MaxSubstrLen, _Seen, CurrentMaxSplits) when CurrentSubstrLen > MaxSubstrLen ->
    CurrentMaxSplits;
solve_loop(S, CurrentSubstrLen, MaxSubstrLen, Seen, CurrentMaxSplits) ->
    Substr = binary:part(S, 0, CurrentSubstrLen),

    NewMaxSplits = 
        if
            sets:is_element(Substr, Seen) ->
                CurrentMaxSplits;
            true ->
                NewSeen = sets:add_element(Substr, Seen),
                Rest = binary:part(S, CurrentSubstrLen, MaxSubstrLen - CurrentSubstrLen),
                ResultForThisPath = solve(Rest, NewSeen),
                max(CurrentMaxSplits, ResultForThisPath)
        end,

    solve_loop(S, CurrentSubstrLen + 1, MaxSubstrLen, Seen, NewMaxSplits).