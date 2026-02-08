-module(solution).
-export([min_difference/1]).

min_difference(Nums) ->
    N = length(Nums),
    if
        N =< 4 -> 0;
        true ->
            SortedNums = lists:sort(Nums),

            % Get the first 4 elements
            [A1, A2, A3, A4 | _] = SortedNums,

            % Get the last 4 elements by reversing and pattern matching
            % This is efficient for fixed small number of elements from the end
            [AN, AN_1, AN_2, AN_3 | _] = lists:reverse(SortedNums),

            % Calculate the four possible minimum differences after 3 moves
            % 1. Remove 3 smallest elements (A1, A2, A3)
            Diff1 = AN - A4,

            % 2. Remove 2 smallest elements (A1, A2) and 1 largest element (AN)
            Diff2 = AN_1 - A3,

            % 3. Remove 1 smallest element (A1) and 2 largest elements (AN_1, AN)
            Diff3 = AN_2 - A2,

            % 4. Remove 3 largest elements (AN_2, AN_1, AN)
            Diff4 = AN_3 - A1,

            % Return the minimum of these four differences
            min(Diff1, min(Diff2, min(Diff3, Diff4)))
    end.