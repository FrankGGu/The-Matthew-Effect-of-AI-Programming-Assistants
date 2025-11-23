-module(longest_palindrome_subsequence_k).
-export([longest_palindrome_subseq_k/2]).

longest_palindrome_subseq_k(S, K) ->
    N = length(S),
    Memo = dict:new(),
    longest_palindrome_subseq_k_helper(S, 0, N - 1, K, Memo).

longest_palindrome_subseq_k_helper(S, I, J, K, Memo) ->
    case dict:find({I, J, K}, Memo) of
        {ok, Result} ->
            Result;
        error ->
            Result =
                case I > J of
                    true ->
                        0;
                    false ->
                        case I == J of
                            true ->
                                1;
                            false ->
                                case lists:nth(I + 1, S) == lists:nth(J + 1, S) of
                                    true ->
                                        2 + longest_palindrome_subseq_k_helper(S, I + 1, J - 1, K, Memo);
                                    false ->
                                        case K > 0 of
                                            true ->
                                                max(longest_palindrome_subseq_k_helper(S, I + 1, J, K - 1, Memo),
                                                    longest_palindrome_subseq_k_helper(S, I, J - 1, K - 1, Memo),
                                                    longest_palindrome_subseq_k_helper(S, I + 1, J - 1, K - 1, Memo) + 2,
                                                    longest_palindrome_subseq_k_helper(S, I + 1, J, K, Memo),
                                                    longest_palindrome_subseq_k_helper(S, I, J - 1, K, Memo));
                                            false ->
                                                max(longest_palindrome_subseq_k_helper(S, I + 1, J, K, Memo),
                                                    longest_palindrome_subseq_k_helper(S, I, J - 1, K, Memo))
                                        end
                                end
                        end
                end,
            dict:store({I, J, K}, Result, Memo),
            Result
    end.

max(A, B) ->
    max(A, B, -1, -1, -1).

max(A, B, C, D, E) ->
  lists:max([A,B,C,D,E]).