-module(solution).
-export([max_length_good_subsequence/2]).

max_length_good_subsequence(S, K) ->
    Chars = string:to_list(S),
    N = length(Chars),
    DP = build_dp(0, N, Chars, K, []),
    lists:max(DP).

build_dp(CurrentIndex, N, AllChars, K, AccDPValues) when CurrentIndex < N ->
    CurrentChar = lists:nth(CurrentIndex + 1, AllChars),

    MaxLenForCurrent = 1,

    PreviousChars = lists:sublist(AllChars, CurrentIndex),
    Pairs = lists:zip(PreviousChars, AccDPValues),

    NewMaxLen = lists:foldl(
        fun({PrevChar, PrevLen}, CurrentMax) ->
            if
                abs(CurrentChar - PrevChar) =< K ->
                    max(CurrentMax, PrevLen + 1);
                true ->
                    CurrentMax
            end
        end,
        MaxLenForCurrent,
        Pairs
    ),

    build_dp(CurrentIndex + 1, N, AllChars, K, AccDPValues ++ [NewMaxLen]);

build_dp(N, N, _AllChars, _K, AccDPValues) ->
    AccDPValues.