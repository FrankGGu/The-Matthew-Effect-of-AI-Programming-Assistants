-module(solution).
-export([countPalindromicSubsequences/1]).

countPalindromicSubsequences(S) ->
    N = string:length(S),
    Counts = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            Counts = lists:update_element(J + 1, 
                lists:update_element(I + 1, 
                if 
                    I == J -> 1;
                    S:substring(S, I + 1) == S:substring(S, J + 1) -> Counts[J + 1][I + 1] + 1;
                    true -> Counts[J + 1][I + 1]
                end, 
                Counts), 
                Counts)
        end, lists:seq(0, N - 1))
    end, lists:seq(0, N - 1)),
    lists:foldl(fun(X, Acc) -> Acc + lists:nth(X + 1, lists:nth(X + 1, Counts)) end, 0, lists:seq(0, N - 1)).