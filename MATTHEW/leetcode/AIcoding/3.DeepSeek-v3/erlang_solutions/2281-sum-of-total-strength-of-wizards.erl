-module(solution).
-export([total_strength/1]).

total_strength(Strength) ->
    N = length(Strength),
    Prefix = lists:foldl(fun(X, [H|T]) -> [H + X | [H|T]] end, [0], Strength),
    PrefixPrefix = lists:foldl(fun(X, [H|T]) -> [H + X | [H|T]] end, [0], Prefix),
    Left = left_min(Strength),
    Right = right_min(Strength),
    lists:foldl(fun(I, Acc) ->
        L = lists:nth(I + 1, Left) + 1,
        R = lists:nth(I + 1, Right) - 1,
        Sum = (lists:nth(R + 2, PrefixPrefix) - lists:nth(L + 1, PrefixPrefix)) * lists:nth(I + 1, Strength),
        (Acc + Sum) rem 1000000007
    end, 0, lists:seq(0, N - 1)).

left_min(Strength) ->
    N = length(Strength),
    Stack = [],
    Left = lists:duplicate(N, -1),
    left_min_helper(Strength, 0, Stack, Left).

left_min_helper([], _, Stack, Left) ->
    Left;
left_min_helper([H|T], I, Stack, Left) ->
    NewStack = case Stack of
        [] -> [];
        [{Val, Pos}|Rest] when Val >= H -> left_min_helper([H|T], I, Rest, Left);
        _ -> Stack
    end,
    NewLeft = case NewStack of
        [] -> setelement(I + 1, Left, -1);
        [{_, Pos}|_] -> setelement(I + 1, Left, Pos)
    end,
    left_min_helper(T, I + 1, [{H, I}|NewStack], NewLeft).

right_min(Strength) ->
    N = length(Strength),
    Stack = [],
    Right = lists:duplicate(N, N),
    right_min_helper(Strength, N - 1, Stack, Right).

right_min_helper([], _, Stack, Right) ->
    Right;
right_min_helper([H|T], I, Stack, Right) ->
    NewStack = case Stack of
        [] -> [];
        [{Val, Pos}|Rest] when Val > H -> right_min_helper([H|T], I, Rest, Right);
        _ -> Stack
    end,
    NewRight = case NewStack of
        [] -> setelement(I + 1, Right, length(Strength));
        [{_, Pos}|_] -> setelement(I + 1, Right, Pos)
    end,
    right_min_helper(T, I - 1, [{H, I}|NewStack], NewRight).