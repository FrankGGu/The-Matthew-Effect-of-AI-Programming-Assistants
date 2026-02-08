-module(solution).
-export([find_max_form/3]).

%% Function to count the number of 0's and 1's in a string
-spec count_zeros_ones(string()) -> {integer(), integer()}.
count_zeros_ones(Str) ->
    {length([X || X <- Str, X =:= $0]), length([X || X <- Str, X =:= $1])}.

%% Dynamic Programming to find the maximum subset
-spec find_max_form([unicode:unicode_binary()], integer(), integer()) -> integer().
find_max_form(Strs, M, N) ->
    %% Initialize the DP table
    DP = lists:duplicate((M + 1) * (N + 1), 0),
    %% Call the helper function to fill the DP table
    fill_dp(Strs, M, N, DP).

%% Helper function to update DP table for each string in the list
-spec fill_dp([unicode:unicode_binary()], integer(), integer(), list(integer())) -> integer().
fill_dp([], _, _, DP) -> lists:last(DP);
fill_dp([Str | Rest], M, N, DP) ->
    {ZeroCount, OneCount} = count_zeros_ones(Str),
    %% Skip strings that cannot fit in the subset (exceeds m 0's or n 1's)
    if
        ZeroCount =< M andalso OneCount =< N -> 
            DP1 = update_dp(DP, M, N, ZeroCount, OneCount);
        true -> DP
    end,
    fill_dp(Rest, M, N, DP1).

%% Function to update the DP table based on the current string
-spec update_dp(list(integer()), integer(), integer(), integer(), integer()) -> list(integer()).
update_dp(DP, M, N, ZeroCount, OneCount) ->
    lists:map(fun(Index) ->
        {Row, Col} = divrem(Index, M + 1),
        %% Check if it can be included in the subset
        if
            Row + ZeroCount =< M andalso Col + OneCount =< N ->
                max(DP, Index + (ZeroCount * (M + 1) + OneCount));
            true -> DP
        end
    end, DP).

%% Find the maximum of two numbers
-spec max(integer(), integer()) -> integer().
max(A, B) when A >= B -> A;
max(_, B) -> B.
