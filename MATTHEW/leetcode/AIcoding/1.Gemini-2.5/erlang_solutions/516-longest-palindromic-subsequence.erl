-module(longest_palindromic_subsequence).
-export([longestPalindromeSubseq/1]).

longestPalindromeSubseq(S) ->
    N = length(S),
    case N of
        0 -> 0;
        _ ->
            BinaryS = unicode:characters_to_binary(S),
            {Result, _Memo} = lps_memo(0, N - 1, BinaryS, #{}),
            Result
    end.

lps_memo(I, J, _BinaryS, Memo) when I > J ->
    {0, Memo};
lps_memo(I, J, _BinaryS, Memo) when I == J ->
    {1, Memo};
lps_memo(I, J, BinaryS, Memo) ->
    case maps:find({I, J}, Memo) of
        {ok, Val} ->
            {Val, Memo};
        _ ->
            CharI = binary:at(BinaryS, I),
            CharJ = binary:at(BinaryS, J),

            if CharI == CharJ ->
                {Val, NewMemo} = lps_memo(I + 1, J - 1, BinaryS, Memo),
                Result = 2 + Val,
                {Result, maps:put({I, J}, Result, NewMemo)};
            true ->
                {Val1, Memo1} = lps_memo(I + 1, J, BinaryS, Memo),
                {Val2, Memo2} = lps_memo(I, J - 1, BinaryS, Memo1),
                Result = max(Val1, Val2),
                {Result, maps:put({I, J}, Result, Memo2)}
            end
    end.