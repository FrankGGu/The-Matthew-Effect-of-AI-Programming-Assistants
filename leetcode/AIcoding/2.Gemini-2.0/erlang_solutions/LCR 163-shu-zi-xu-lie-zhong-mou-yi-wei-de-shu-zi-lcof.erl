-module(find_kth_number).
-export([findKthNumber/2]).

findKthNumber(N, K) ->
    findKthNumberHelper(N, K, 1).

findKthNumberHelper(N, K, Curr) ->
    First := Curr,
    Last := Curr + 1,
    Steps := countSteps(First, Last, N),
    case K of
        1 ->
            Curr;
        _ ->
            if Steps <= K - 1 then
                findKthNumberHelper(N, K - Steps, Last)
            else
                findKthNumberHelper(N, K - 1, Curr * 10)
            end
    end.

countSteps(First, Last, N) ->
    Steps = 0,
    while First <= N do
        Steps = Steps + min(N + 1, Last) - First,
        First = First * 10,
        Last = Last * 10
    end,
    Steps.