-module(solution).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    N = length(S),
    if N == 0 -> 0;
       true ->
            DP = array:new([{size, N}, {default, array:new([{size, N}, {default, false}])}]),
            MaxLen = 1,
            {DP1, MaxLen1} = fill_dp(S, DP, MaxLen, N),
            MaxLen1
    end.

fill_dp(S, DP, MaxLen, N) ->
    fill_dp(S, DP, MaxLen, N, 0).

fill_dp(S, DP, MaxLen, N, I) when I >= N ->
    {DP, MaxLen};
fill_dp(S, DP, MaxLen, N, I) ->
    DP1 = array:set(I, array:set(I, true, array:get(I, DP)), DP),
    fill_dp(S, DP1, MaxLen, N, I + 1, I).

fill_dp(S, DP, MaxLen, N, I, J) when J >= N ->
    fill_dp(S, DP, MaxLen, N, I + 1);
fill_dp(S, DP, MaxLen, N, I, J) ->
    case I + 1 >= J - 1 of
        true ->
            case lists:nth(I + 1, S) == lists:nth(J + 1, S) of
                true ->
                    DP1 = array:set(I, array:set(J, true, array:get(I, DP)), DP),
                    NewMaxLen = max(MaxLen, J - I + 1),
                    fill_dp(S, DP1, NewMaxLen, N, I, J + 1);
                false ->
                    fill_dp(S, DP, MaxLen, N, I, J + 1)
            end;
        false ->
            case (lists:nth(I + 1, S) == lists:nth(J + 1, S)) andalso array:get(I + 1, array:get(J - 1, DP)) of
                true ->
                    DP1 = array:set(I, array:set(J, true, array:get(I, DP)), DP),
                    NewMaxLen = max(MaxLen, J - I + 1),
                    fill_dp(S, DP1, NewMaxLen, N, I, J + 1);
                false ->
                    fill_dp(S, DP, MaxLen, N, I, J + 1)
            end
    end.