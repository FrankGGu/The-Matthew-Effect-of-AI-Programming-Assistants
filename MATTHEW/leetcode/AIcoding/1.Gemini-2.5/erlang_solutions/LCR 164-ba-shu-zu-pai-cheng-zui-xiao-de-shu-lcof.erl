-module(solution).
-export([largest_number/1]).

largest_number(Nums) ->
    StrNums = [integer_to_list(N) || N <- Nums],

    % Custom comparison function for sorting.
    % For two numbers A and B (as strings), we compare A++B and B++A.
    % To form the largest number, we want A to come before B if A++B is lexicographically greater than B++A.
    %
    % The `lists:sort/2` function expects a comparison function `Fun(X, Y)` that returns `true`
    % if `X` is considered "less than or equal to" `Y` in the desired ascending order.
    %
    % If we want to sort `A` before `B` when `A++B > B++A`, this is effectively a descending sort
    % based on this custom comparison.
    %
    % One way to achieve a descending sort with `lists:sort/2` is to define the comparison
    % function such that it produces an ascending sort for the *reverse* of the desired order,
    % and then reverse the final list.
    %
    % Let's define `Fun(A, B)` to return `true` if `A` should come before `B` to form the *smallest* number.
    % `A` should come before `B` to form the smallest number if `A++B < B++A`.
    % Example: For ["1", "0"], `Fun("0", "1")` is `("0"++"1") < ("1"++"0")` -> `"01" < "10"` -> `true`.
    % So, `0` comes before `1`. The sorted list would be `["0", "1"]`.
    % Example: For ["3", "30"], `Fun("3", "30")` is `("3"++"30") < ("30"++"3")` -> `"330" < "303"` -> `false`.
    % So, `3` is not considered `<= 30`. Thus `30` comes before `3`. The sorted list would be `["30", "3"]`.
    %
    % So, `lists:sort(fun(A, B) -> (A ++ B) < (B ++ A) end, StrNums)` sorts to produce the smallest number.
    % To get the largest number, we simply reverse this sorted list.
    SortedForSmallest = lists:sort(fun(A, B) -> (A ++ B) < (B ++ A) end, StrNums),

    SortedForLargest = lists:reverse(SortedForSmallest),

    % Handle the edge case where all numbers are zero.
    % E.g., [0,0,0] should result in "0", not "000".
    % If the first element of the final sorted list (for largest number) is "0",
    % it implies all numbers were zeros, or the largest number starts with zero
    % (which only happens if all numbers are zero).
    case SortedForLargest of
        ["0"|_] ->
            "0";
        _ ->
            lists:flatten(SortedForLargest)
    end.