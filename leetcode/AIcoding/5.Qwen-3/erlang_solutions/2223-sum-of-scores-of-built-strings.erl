-module(solution).
-export([sum_scores/1]).

sum_scores(S) ->
    N = length(S),
    Scores = lists:seq(0, N-1),
    lists:foldl(fun(I, Acc) -> Acc + score(S, I) end, 0, Scores).

score(S, I) ->
    N = length(S),
    K = 0,
    Count = 0,
    score_helper(S, I, K, Count, N).

score_helper(S, I, K, Count, N) when K < N - I ->
    case string:slice(S, I, K+1) of
        Sub when Sub == string:slice(S, 0, K+1) ->
            score_helper(S, I, K+1, Count + 1, N);
        _ ->
            Count
    end;
score_helper(_, _, _, Count, _) ->
    Count.