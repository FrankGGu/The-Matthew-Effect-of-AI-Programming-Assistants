-module(solution).
-export([find_lexicographically_largest_string/1]).

find_lexicographically_largest_string(S) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, string:to_list(S)),
    string:from_list(Sorted).