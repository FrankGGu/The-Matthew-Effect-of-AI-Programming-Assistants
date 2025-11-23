-module(solution).
-export([add_operators/2]).

add_operators(Num, Target) ->
    case Num of
        "" -> [];
        _ ->
            Result = [],
            dfs(Num, Target, 0, 0, 0, [], Result),
            Result
    end.

dfs([], Target, Value, Prev, Curr, Path, Result) ->
    if
        Value + Prev * Curr == Target ->
            Expr = lists:reverse(Path),
            Result = [Expr | Result];
        true ->
            Result
    end;
dfs([H | T], Target, Value, Prev, Curr, Path, Result) ->
    Digit = H - $0,
    NewCurr = Curr * 10 + Digit,
    NewPath = [H | Path],
    if
        Curr == 0 ->
            Result1 = dfs(T, Target, Value, Prev, NewCurr, NewPath, Result),
            Result1;
        true ->
            Result1 = dfs(T, Target, Value, Prev, NewCurr, NewPath, Result),
            Result2 = dfs(T, Target, Value + Prev * Curr, 1, Digit, [$+ | NewPath], Result1),
            Result3 = dfs(T, Target, Value + Prev * Curr, -1, Digit, [$- | NewPath], Result2),
            dfs(T, Target, Value, Prev * Curr, Digit, [$* | NewPath], Result3)
    end.