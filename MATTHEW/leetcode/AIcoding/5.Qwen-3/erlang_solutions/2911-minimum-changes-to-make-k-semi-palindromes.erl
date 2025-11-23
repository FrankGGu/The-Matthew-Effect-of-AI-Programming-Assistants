-module(solution).
-export([min_changes/1]).

min_changes(S) ->
    N = length(S),
    K = 1,
    min_changes(S, N, K).

min_changes(_, _, 0) -> 0;
min_changes(S, N, K) ->
    Min = lists:foldl(fun(I, Acc) ->
        Sub = string:substr(S, I, N - I + 1),
        L = length(Sub),
        if
            L < K -> Acc;
            true ->
                Cost = cost(Sub, K),
                if
                    Cost == -1 -> Acc;
                    true -> min(Acc, Cost)
                end
        end
    end, infinity, lists:seq(1, N - K + 1)).

cost(_, 0) -> 0;
cost(S, K) ->
    N = length(S),
    if
        N < K -> -1;
        true ->
            {MinCost, _} = lists:foldl(fun(I, {Acc, Last}) ->
                Sub = string:substr(S, I, N - I + 1),
                Len = length(Sub),
                if
                    Len < K -> {Acc, Last};
                    true ->
                        {NewAcc, NewLast} = solve(Sub, K, 0, 0, 0),
                        {min(Acc, NewAcc), NewLast}
                end
            end, {infinity, 0}, lists:seq(1, N - K + 1)),
            MinCost
    end.

solve(_, 0, Cost, _, _) -> {Cost, 0};
solve(S, K, Cost, Start, End) ->
    N = length(S),
    if
        End >= N -> {Cost, End};
        true ->
            NextEnd = End + 1,
            if
                NextEnd > N -> {Cost, End};
                true ->
                    Sub = string:substr(S, Start + 1, NextEnd - Start),
                    Len = length(Sub),
                    if
                        Len < K -> solve(S, K, Cost, Start, NextEnd);
                        true ->
                            if
                                is_semi_palindrome(Sub, K) ->
                                    solve(S, K - 1, Cost + 1, NextEnd, NextEnd);
                                true ->
                                    solve(S, K, Cost, Start, NextEnd)
                            end
                    end
            end
    end.

is_semi_palindrome(S, K) ->
    N = length(S),
    if
        N < K -> false;
        true ->
            lists:all(fun(I) -> is_palindrome(string:substr(S, I, N - I + 1)) end, lists:seq(1, N - K + 1))
    end.

is_palindrome(S) ->
    S == lists:reverse(S).