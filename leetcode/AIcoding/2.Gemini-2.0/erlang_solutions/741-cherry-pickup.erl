-module(cherry_pickup).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    N = length(Grid),
    dp(Grid, 0, 0, 0, N, []).

dp(_Grid, N, X1, Y1, X2, Y2, Memo) when X1 >= N; X2 >= N; Y1 >= N; Y2 >= N ->
    -100000000.
dp(_Grid, N, X1, Y1, X2, Y2, Memo) when X1 < 0; X2 < 0; Y1 < 0; Y2 < 0 ->
    -100000000.
dp(Grid, N, X1, Y1, X2, Y2, _Memo) when X1 == N - 1, Y1 == N - 1 ->
    lists:nth(N, lists:nth(N, Grid));
dp(Grid, N, X1, Y1, X2, Y2, _Memo) when X2 == N - 1, Y2 == N - 1 ->
    lists:nth(N, lists:nth(N, Grid));
dp(Grid, N, X1, Y1, X2, Y2, Memo) ->
    case lists:keyfind({X1, Y1, X2, Y2}, 1, Memo) of
        false ->
            Val1 = lists:nth(Y1+1, lists:nth(X1+1, Grid)),
            Val2 = lists:nth(Y2+1, lists:nth(X2+1, Grid)),
            Val = if X1 == X2, Y1 == Y2 then Val1 else Val1 + Val2 end,

            A = dp(Grid, N, X1+1, Y1, X2+1, Y2, Memo),
            B = dp(Grid, N, X1+1, Y1, X2, Y2+1, Memo),
            C = dp(Grid, N, X1, Y1+1, X2+1, Y2, Memo),
            D = dp(Grid, N, X1, Y1+1, X2, Y2+1, Memo),

            MaxVal = max_list([A, B, C, D]),

            Result = Val + MaxVal,

            NewMemo = [{X1, Y1, X2, Y2, Result} | Memo],

            if Result < 0 then
                0
            else
                lists:keyfind({X1, Y1, X2, Y2, Result}, 5, NewMemo) ! false,
                Result
            end;
        {X1, Y1, X2, Y2, Result} ->
            Result
    end.

max_list([H|T]) ->
    max_list(T, H).

max_list([], Max) ->
    Max;
max_list([H|T], Max) ->
    if H > Max then
        max_list(T, H)
    else
        max_list(T, Max)
    end.