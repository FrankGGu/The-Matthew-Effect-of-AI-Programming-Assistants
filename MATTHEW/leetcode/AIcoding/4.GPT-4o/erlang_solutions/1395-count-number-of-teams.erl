-module(solution).
-export([num_teams/1]).

num_teams(Ranks) ->
    N = length(Ranks),
    count_teams(Ranks, N, 0).

count_teams(Ranks, N, Count) ->
    case N of
        3 -> Count + count_combinations(Ranks, 3);
        _ -> Count + count_teams(Ranks, N - 1)
    end.

count_combinations(_, 0) -> 1;
count_combinations([], _) -> 0;
count_combinations([H | T], K) ->
    count_combinations(T, K - 1) + count_combinations(T, K).

count_teams(Ranks, N, Count) ->
    lists:foldl(fun(X, Acc) ->
        Acc + count_valid_teams(X, Ranks)
    end, Count, lists:seq(1, N)).

count_valid_teams(X, Ranks) ->
    count_increasing(X, Ranks) + count_decreasing(X, Ranks).

count_increasing(X, Ranks) ->
    lists:foldl(fun(Y, Acc) ->
        if
            Y < X -> Acc + 1;
            true -> Acc
        end
    end, 0, Ranks).

count_decreasing(X, Ranks) ->
    lists:foldl(fun(Y, Acc) ->
        if
            Y > X -> Acc + 1;
            true -> Acc
        end
    end, 0, Ranks).