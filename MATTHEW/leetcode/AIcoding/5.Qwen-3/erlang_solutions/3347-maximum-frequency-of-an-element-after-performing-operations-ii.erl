-module(solution).
-export([max_freq/2]).

max_freq(Nums, k) ->
    lists:sort(Nums),
    max_freq(Nums, k, 0, 0, 0).

max_freq([], _, _, _, Max) -> Max;
max_freq([H | T], K, Left, Total, Max) ->
    Total1 = Total + H,
    while_left(Total1, H, K, Left, T, Total, Max).

while_left(Total, H, K, Left, T, Total, Max) when (H * (Left + 1) - Total) > K ->
    NewTotal = Total - lists:nth(Left + 1, [H | T]),
    max_freq(T, K, Left + 1, NewTotal, Max);
while_left(Total, H, K, Left, T, Total, Max) ->
    CurrentMax = Left + 1,
    max_freq(T, K, Left, Total, erlang:max(Max, CurrentMax)).

lists:nth(0, _) -> error;
lists:nth(N, [H | T]) when N == 1 -> H;
lists:nth(N, [_ | T]) -> lists:nth(N - 1, T).