-module(solution).
-export([longestCommonSubsequence/2]).

longestCommonSubsequence(Text1, Text2) ->
    L1 = length(Text1),
    L2 = length(Text2),
    Text1Bin = list_to_binary(Text1),
    Text2Bin = list_to_binary(Text2),
    DP = maps:new(),
    solve_dp(Text1Bin, Text2Bin, L1, L2, DP).

solve_dp(Text1Bin, Text2Bin, L1, L2, DP) ->
    FinalDP = lists:foldl(
        fun(I, CurrentDP) ->
            lists:foldl(
                fun(J, InnerDP) ->
                    Val = calculate_dp_value(Text1Bin, Text2Bin, I, J, InnerDP),
                    maps:put({I,J}, Val, InnerDP)
                end,
                CurrentDP,
                lists:seq(1, L2)
            )
        end,
        DP,
        lists:seq(1, L1)
    ),
    maps:get({L1, L2}, FinalDP, 0).

calculate_dp_value(Text1Bin, Text2Bin, I, J, DP) ->
    Char1 = binary:at(Text1Bin, I - 1),
    Char2 = binary:at(Text2Bin, J - 1),
    if Char1 == Char2 ->
           maps:get({I-1, J-1}, DP, 0) + 1;
       true ->
           max(maps:get({I-1, J}, DP, 0), maps:get({I, J-1}, DP, 0))
    end.