-module(palindrome_partitioning_ii).
-export([min_cut/1]).

min_cut(S) ->
    N = length(S),
    IsPalindrome = build_is_palindrome_table(S),
    DP = array:new(N, {default, 0}),
    array:set(0, 0, DP),
    min_cut_helper(S, IsPalindrome, DP, 1).

min_cut_helper(_, _, DP, N) ->
    array:get(N - 1, DP);
min_cut_helper(S, IsPalindrome, DP, I) ->
    Min = min_cut_helper2(S, IsPalindrome, DP, I, 0, I - 1),
    array:set(I, Min, DP),
    min_cut_helper(S, IsPalindrome, DP, I + 1).

min_cut_helper2(_, _, DP, I, J, MaxJ) when J > MaxJ ->
    array:get(I - 1, DP) + 1;
min_cut_helper2(S, IsPalindrome, DP, I, J, MaxJ) ->
    if
        array:get(J, IsPalindrome) == 1 ->
            CurrentMin = array:get(I - 1, DP) + 1,
            PreviousMin = min_cut_helper2(S, IsPalindrome, DP, I, J + 1, MaxJ),
            min(CurrentMin, PreviousMin);
        true ->
            min_cut_helper2(S, IsPalindrome, DP, I, J + 1, MaxJ)
    end.

build_is_palindrome_table(S) ->
    N = length(S),
    Table = array:new(N, {default, 0}),
    build_is_palindrome_table(S, Table, 0, N - 1).

build_is_palindrome_table(S, Table, I, J) when I > J ->
    Table;
build_is_palindrome_table(S, Table, I, J) ->
    case is_palindrome(S, I, J) of
        true ->
            Table1 = array:set(I * N + J, 1, Table),
            build_is_palindrome_table(S, Table1, I + 1, J);
        false ->
            Table1 = array:set(I * N + J, 0, Table),
            build_is_palindrome_table(S, Table1, I + 1, J)
    end.

is_palindrome(S, I, J) ->
    is_palindrome(S, I, J, 0).

is_palindrome(S, I, J, K) when I + K > J - K ->
    true;
is_palindrome(S, I, J, K) ->
    if
        lists:nth(I + K + 1, S) == lists:nth(J - K + 1, S) ->
            is_palindrome(S, I, J, K + 1);
        true ->
            false
    end.