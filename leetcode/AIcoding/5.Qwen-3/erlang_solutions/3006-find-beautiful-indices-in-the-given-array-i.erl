-module(solution).
-export([beautiful_indices/2]).

beautiful_indices(Nums, k) ->
    N = length(Nums),
    Results = lists:seq(0, N-1),
    lists:filter(fun(I) -> is_beautiful(Nums, I, k) end, Results).

is_beautiful(_, _, 0) -> true;
is_beautiful(Nums, I, K) ->
    Len = length(Nums),
    Left = I - K,
    Right = I + K,
    case Left < 0 of
        true -> not has_duplicate(Nums, I, Right);
        false -> not has_duplicate(Nums, Left, I) andalso not has_duplicate(Nums, I, Right)
    end.

has_duplicate(Nums, Start, End) ->
    Start >= End orelse
    lists:any(fun(J) -> J == element(Start+1, Nums) end, lists:seq(Start+1, End)).