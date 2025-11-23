-module(solution).
-export([longest_palindrome_subseq/1]).

-spec longest_palindrome_subseq(unicode:unicode_binary()) -> integer().
longest_palindrome_subseq(S) ->
    Length = length(S),
    %% Create a DP table to store the length of the longest palindromic subsequence
    %% for each substring S[i..j].
    DP = lists:duplicate(Length, lists:duplicate(Length, 0)),
    %% Fill the DP table
    fill_dp(S, Length, DP).

%% Helper function to fill the DP table.
fill_dp(S, Length, DP) ->
    %% Base case: every character is a palindrome of length 1.
    DP1 = lists:map(fun(_) -> lists:map(fun(_) -> 0 end, lists:duplicate(Length, 0)) end, DP),
    DP2 = fill_dp_diagonal(S, DP1, Length),
    %% The result is stored in DP[0][Length-1]
    lists:nth(Length, lists:nth(Length, DP2)).

%% Function to fill diagonal values for the DP table.
fill_dp_diagonal(_, DP, 0) -> DP;
fill_dp_diagonal(S, DP, I) ->
    fill_dp_diagonal_helper(S, DP, I, I),
    fill_dp_diagonal(S, DP, I-1).

fill_dp_diagonal_helper(S, DP, I, J) ->
    if
        lists:nth(I, S) == lists:nth(J, S) ->
            lists:replace(J, lists:nth(J, DP), lists:nth(I, DP) + 1);
        true ->
            lists:replace(J, lists:nth(J, DP), max(lists:nth(J-1, DP), lists:nth(J, DP)))
    end.
