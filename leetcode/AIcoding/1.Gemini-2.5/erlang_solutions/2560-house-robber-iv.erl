-module(solution).
-export([min_capability/2]).

min_capability(Nums, K) ->
    case K of
        0 -> 0;
        _ ->
            MaxVal = lists:max(Nums),
            binary_search(Nums, K, 0, MaxVal, MaxVal)
    end.

binary_search(Nums, K, Low, High, Ans) ->
    if Low > High ->
        Ans;
    else
        Mid = Low + (High - Low) div 2,
        case can_rob(Nums, K, Mid) of
            true ->
                binary_search(Nums, K, Low, Mid - 1, Mid);
            false ->
                binary_search(Nums, K, Mid + 1, High, Ans)
        end
    end.

can_rob(Nums, K, MaxVal) ->
    can_rob_recursive(Nums, K, MaxVal, 0).

can_rob_recursive([], K, _MaxVal, Count) ->
    Count >= K;
can_rob_recursive([H|T], K, MaxVal, Count) ->
    if H =< MaxVal ->
        % Rob this house, skip the next one
        NextList = case T of
                       [] -> [];
                       [_NextH | RestOfT] -> RestOfT
                   end,
        can_rob_recursive(NextList, K, MaxVal, Count + 1);
    else
        % Cannot rob this house, move to the next
        can_rob_recursive(T, K, MaxVal, Count)
    end.