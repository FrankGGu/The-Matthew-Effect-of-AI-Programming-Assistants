-spec min_cost(nums :: [integer()]) -> integer().
min_cost(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Median = lists:nth((Len + 1) div 2, Sorted),
    Candidates = find_palindromes(Median, lists:max(Sorted)),
    lists:min([calculate_cost(Nums, C) || C <- Candidates]).

find_palindromes(Target, Max) ->
    Palindromes = [],
    find_palindromes(Target, Max, -1, 1, Palindromes).

find_palindromes(Target, Max, Dir, Delta, Acc) ->
    Current = Target + Dir * Delta,
    if
        Current < 0 -> find_palindromes(Target, Max, 1, 1, Acc);
        Current > Max -> Acc;
        true ->
            case is_palindrome(Current) of
                true -> find_palindromes(Target, Max, Dir, Delta + 1, [Current | Acc]);
                false -> find_palindromes(Target, Max, Dir, Delta + 1, Acc)
            end
    end.

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).

calculate_cost(Nums, Target) ->
    lists:sum([abs(N - Target) || N <- Nums]).