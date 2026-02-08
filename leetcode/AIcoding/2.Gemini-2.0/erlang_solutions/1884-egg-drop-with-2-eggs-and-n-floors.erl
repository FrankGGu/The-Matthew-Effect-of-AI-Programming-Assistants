-module(egg_drop).
-export([superEggDrop/1]).

superEggDrop(N) ->
    memo(N, 2, []).

memo(N, 0, _) ->
    0;
memo(0, _, _) ->
    0;
memo(N, 1, _) ->
    N;
memo(N, K, Memo) ->
    case lists:keyfind({N, K}, 1, Memo) of
        false ->
            Res = solve(N, K, Memo),
            memo(N, K, [{N, K, Res}|Memo]);
        {_, _, R} ->
            R
    end.

solve(N, K, Memo) ->
    BinSearch = fun(Low, High) ->
        binarySearch(Low, High, N, K, Memo)
    end,
    BinSearch(1, N).

binarySearch(Low, High, N, K, Memo) ->
    if Low > High then
        infinity
    else
        Mid = Low + (High - Low) div 2,
        Break = memo(Mid - 1, K - 1, Memo),
        NotBreak = memo(N - Mid, K, Memo),
        if Break > NotBreak then
            binarySearch(Low, Mid - 1, N, K, Memo)
        else if Break < NotBreak then
            binarySearch(Mid + 1, High, N, K, Memo)
        else
            1 + Break
        end
    end.

infinity ->
    1000000000.