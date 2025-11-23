-module(solution).
-export([smallestTrimmedNumbers/2]).

smallestTrimmedNumbers(Nums, Queries) ->
    [ solve_query(Nums, Query) || Query <- Queries ].

solve_query(Nums, [K, Trim]) ->
    IndexedNums = lists:zip(Nums, lists:seq(0, length(Nums) - 1)),

    TrimmedAndIndexed = [
        begin
            NumLen = length(NumStr),
            % Calculate the starting position for the substring.
            % If Trim is greater than NumLen, we take the entire string,
            % so the start index will be 1.
            % string:substr is 1-indexed.
            SubstrStart = max(1, NumLen - Trim + 1),
            TrimmedStr = string:substr(NumStr, SubstrStart, Trim),
            {list_to_integer(TrimmedStr), OriginalIndex}
        end
        || {NumStr, OriginalIndex} <- IndexedNums
    ],

    % Sort the list of {TrimmedValue, OriginalIndex} tuples.
    % lists:sort sorts based on the first element, then the second for ties,
    % which correctly handles the tie-breaking rule (smaller original index).
    Sorted = lists:sort(TrimmedAndIndexed),

    % K is 1-indexed. Get the K-th element and extract its original index.
    {_TrimmedValue, ResultIndex} = lists:nth(K, Sorted),
    ResultIndex.