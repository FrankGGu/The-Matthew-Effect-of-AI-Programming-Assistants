-module(longest_palindrome_subsequence).
-export([longest_palindrome_subseq/1]).

longest_palindrome_subseq(S) ->
    Len = length(S),
    DP = array:new([Len, Len], {0}),
    longest_palindrome_subseq_helper(S, 0, Len - 1, DP).

longest_palindrome_subseq_helper(S, I, J, DP) ->
    case array:get({I, J}, DP) of
        0 ->
            case I > J of
                true ->
                    0;
                false ->
                    case I == J of
                        true ->
                            array:set({I, J}, 1, DP),
                            1;
                        false ->
                            case lists:nth(I + 1, S) == lists:nth(J + 1, S) of
                                true ->
                                    Result = 2 + longest_palindrome_subseq_helper(S, I + 1, J - 1, DP),
                                    array:set({I, J}, Result, DP),
                                    Result;
                                false ->
                                    Result1 = longest_palindrome_subseq_helper(S, I + 1, J, DP),
                                    Result2 = longest_palindrome_subseq_helper(S, I, J - 1, DP),
                                    Result = max(Result1, Result2),
                                    array:set({I, J}, Result, DP),
                                    Result
                            end
                    end
            end;
        Result ->
            Result
    end.