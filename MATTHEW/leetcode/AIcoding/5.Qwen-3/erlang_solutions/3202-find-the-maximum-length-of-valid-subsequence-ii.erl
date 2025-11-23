-module(solution).
-export([find_max_length_of_valid_subsequence/1]).

find_max_length_of_valid_subsequence(Nums) ->
    find_max_length_of_valid_subsequence(Nums, 0, 0, 0).

find_max_length_of_valid_subsequence([], _, Max, _) ->
    Max;
find_max_length_of_valid_subsequence([H | T], Index, Max, Prev) ->
    case H > Prev of
        true ->
            NewMax = max(Max, Index + 1),
            find_max_length_of_valid_subsequence(T, Index + 1, NewMax, H);
        false ->
            find_max_length_of_valid_subsequence(T, Index + 1, Max, Prev)
    end.