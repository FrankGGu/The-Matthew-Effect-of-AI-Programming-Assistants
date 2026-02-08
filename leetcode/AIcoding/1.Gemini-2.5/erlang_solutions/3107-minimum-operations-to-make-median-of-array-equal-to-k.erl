-module(solution).
-export([min_operations_to_make_median_equal_to_k/2]).

-spec min_operations_to_make_median_equal_to_k(Nums :: [integer()], K :: integer()) -> integer().
min_operations_to_make_median_equal_to_k(Nums, K) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    MedianIdx = N div 2, % 0-indexed position of the median

    % Split the sorted list into three parts: left, median, right
    % lists:split(N, List) returns {Prefix, Suffix}
    {LeftPart, Suffix} = lists:split(MedianIdx, SortedNums),

    % Suffix now contains [MedianVal | RightPart]
    [MedianVal | RightPart] = Suffix,

    % Calculate operations for the median element itself
    Ops = abs(MedianVal - K),

    % Calculate operations for elements to the left of the median
    % These elements must be <= K. If any X > K, we must decrease it to K.
    LeftOps = lists:foldl(fun(X, Acc) ->
                                 if X > K -> Acc + (X - K);
                                    true -> Acc
                                 end
                         end, 0, LeftPart),

    % Calculate operations for elements to the right of the median
    % These elements must be >= K. If any X < K, we must increase it to K.
    RightOps = lists:foldl(fun(X, Acc) ->
                                  if X < K -> Acc + (K - X);
                                     true -> Acc
                                  end
                          end, 0, RightPart),

    Ops + LeftOps + RightOps.