-module(solution).
-export([count_palindromic_subsequences/1]).

count_palindromic_subsequences(S) ->
    N = length(S),
    DP = array:new(N, {default, 0}),
    count_palindromic_subsequences(S, 0, N-1, DP).

count_palindromic_subsequences(S, I, J, DP) when I > J -> 0;
count_palindromic_subsequences(S, I, J, DP) when I == J -> 1;
count_palindromic_subsequences(S, I, J, DP) ->
    case array:get(I, J, DP) of
        Val when is_integer(Val) -> Val;
        _ ->
            Res = case element(I, S) of
                      element(J, S) ->
                          2 + count_palindromic_subsequences(S, I+1, J-1, DP);
                      _ ->
                          count_palindromic_subsequences(S, I+1, J, DP) +
                          count_palindromic_subsequences(S, I, J-1, DP) -
                          count_palindromic_subsequences(S, I+1, J-1, DP)
                  end,
            array:set(I, J, Res, DP),
            Res
    end.