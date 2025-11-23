-module(solution).
-export([longest_palindromic_subsequence/2]).

longest_palindromic_subsequence(S, K) ->
    N = length(S),
    D = lists:map(fun(_) -> lists:duplicate(N, 0) end, lists:seq(1, N)),
    lists:foreach(fun(I) -> D = update_dp(S, I, D) end, lists:seq(1, N)),
    MaxLen = lists:max(lists:map(fun(Row) -> lists:max(Row) end, D)),
    MaxLen + K.

update_dp(S, I, D) ->
    N = length(S),
    lists:foldl(fun(J, Acc) ->
        if
            J > I ->
                Acc;
            true ->
                if
                    lists:nth(I, S) == lists:nth(J, S) ->
                        lists:update_element(J, I, lists:nth(J-1, Acc) + 1, Acc);
                    true ->
                        lists:update_element(J, I, lists:max([lists:nth(J, Acc), lists:nth(J-1, Acc)]), Acc)
                end
        end
    end, D, lists:seq(1, N)).