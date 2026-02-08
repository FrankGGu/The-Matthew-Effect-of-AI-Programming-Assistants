-module(solution).
-export([smallest_range_i/2]).

-spec smallest_range_i(A :: [integer()], K :: integer()) -> integer().
smallest_range_i(A, K) ->
    MinVal = lists:min(A),
    MaxVal = lists:max(A),
    Difference = MaxVal - MinVal,
    Result = Difference - 2 * K,
    math:max(0, Result).