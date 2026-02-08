-module(solution).
-export([numberOfSubstrings/1]).

numberOfSubstrings(S) ->
    S_binary = unicode:characters_to_binary(S),
    N = byte_size(S_binary),
    InitialCounts = #{97 => 0, 98 => 0, 99 => 0},
    solve_helper(0, 0, InitialCounts, 0, N, S_binary).

solve_helper(Right, Left, Counts, TotalAns, N, S_binary) when Right < N ->
    CurrentChar = binary:at(S_binary, Right),
    NewCounts = maps:update_with(CurrentChar, fun(V) -> V + 1 end, 1, Counts),

    {UpdatedLeft, UpdatedCounts, UpdatedAns} =
        shrink_and_count(Left, NewCounts, TotalAns, Right, N, S_binary),

    solve_helper(Right + 1, UpdatedLeft, UpdatedCounts, UpdatedAns, N, S_binary);
solve_helper(_Right, _Left, _Counts, TotalAns, _N, _S_binary) ->
    TotalAns.

shrink_and_count(Left, Counts, CurrentAns, Right, N, S_binary) ->
    case (maps:get(97, Counts) > 0 andalso
          maps:get(98, Counts) > 0 andalso
          maps:get(99, Counts) > 0) of
        true ->
            NewAns = CurrentAns + (N - Right),
            CharToRemove = binary:at(S_binary, Left),
            ShrunkCounts = maps:update_with(CharToRemove, fun(V) -> V - 1 end, 0, Counts),
            shrink_and_count(Left + 1, ShrunkCounts, NewAns, Right, N, S_binary);
        false ->
            {Left, Counts, CurrentAns}
    end.