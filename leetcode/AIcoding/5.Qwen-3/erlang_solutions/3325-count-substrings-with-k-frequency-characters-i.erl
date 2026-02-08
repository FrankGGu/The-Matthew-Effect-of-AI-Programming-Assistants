-module(solution).
-export([k_freq_substrings/2]).

k_freq_substrings(S, K) ->
    N = length(S),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Sub = string:substr(S, I, J - I + 1),
            CharCount = lists:foldl(fun(C, M) -> maps:update(C, maps:get(C, M, 0) + 1, M) end, #{}, Sub),
            case maps:values(CharCount) of
                Values when lists:all(fun(V) -> V >= K end, Values) -> Acc2 + 1;
                _ -> Acc2
            end
        end, Acc, lists:seq(I, N))
    end, Count, lists:seq(1, N)).