-module(longest_common_subsequence).
-export([longest_common_subsequence/2]).

longest_common_subsequence(Text1, Text2) ->
    N = length(Text1),
    M = length(Text2),
    DP = array:new([N + 1, M + 1], {default, 0}),
    longest_common_subsequence_helper(Text1, Text2, N, M, DP).

longest_common_subsequence_helper(Text1, Text2, N, M, DP) ->
    case N of
        0 -> 0;
        _ ->
            case M of
                0 -> 0;
                _ ->
                    case array:get({N, M}, DP) of
                        0 ->
                            if
                                lists:nth(N, Text1) == lists:nth(M, Text2) ->
                                    Result = 1 + longest_common_subsequence_helper(Text1, Text2, N - 1, M - 1, DP),
                                    array:set({N, M}, Result, DP),
                                    Result;
                                true ->
                                    Result1 = longest_common_subsequence_helper(Text1, Text2, N - 1, M, DP),
                                    Result2 = longest_common_subsequence_helper(Text1, Text2, N, M - 1, DP),
                                    Result = max(Result1, Result2),
                                    array:set({N, M}, Result, DP),
                                    Result
                            end;
                        Value ->
                            Value
                    end
            end
    end.