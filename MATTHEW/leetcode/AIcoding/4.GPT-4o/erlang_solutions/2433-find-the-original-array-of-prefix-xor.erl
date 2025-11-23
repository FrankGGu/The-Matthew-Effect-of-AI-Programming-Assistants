-module(solution).
-export([find_original_array/1]).

find_original_array(PrefixXor) ->
    N = length(PrefixXor) - 1,
    Original = lists:duplicate(N, 0),
    find_original_array_helper(PrefixXor, Original, 0, N).

find_original_array_helper(_, [], _, _) -> [];
find_original_array_helper(PrefixXor, [H|T], Index, N) ->
    OriginalValue = case Index of
        0 -> H;
        _ -> H bxor lists:nth(Index, PrefixXor)
    end,
    [OriginalValue | find_original_array_helper(PrefixXor, T, Index + 1, N)].