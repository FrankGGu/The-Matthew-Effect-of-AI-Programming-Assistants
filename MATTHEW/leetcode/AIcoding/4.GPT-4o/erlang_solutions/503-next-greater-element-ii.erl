-module(solution).
-export([next_greater_elements/1]).

-spec next_greater_elements([integer()]) -> [integer()].
next_greater_elements(Nums) ->
    N = length(Nums),
    Indices = lists:seq(0, N-1),
    NextGreater = lists:map(fun(Index) -> find_next_greater(Index, Nums, Indices) end, Indices),
    NextGreater.

find_next_greater(Index, Nums, Indices) ->
    Target = lists:nth(Index+1, Nums),
    NextIndex = lists:drop(Index + 1, Indices),
    Case find_greater(Target, NextIndex, Nums) of
      {ok, Greater} -> Greater;
      error -> -1
    end.

find_greater(Target, [], _) -> error;
find_greater(Target, [Index | Rest], Nums) ->
    case lists:nth(Index + 1, Nums) of
        Greater when Greater > Target -> {ok, Greater};
        _ -> find_greater(Target, Rest, Nums)
    end.
