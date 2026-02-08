-module(paint_house_iii).
-export([minCost/2]).

minCost(Price, M) ->
    N = length(Price),
    K = length(hd(Price)),
    {_, Result} = lists:foldl(fun(I, {Prev, Acc}) ->
        lists:foldl(fun(J, {Cur, Acc2}) ->
            if
                J == 0 ->
                    {lists:seq(0, K-1), Acc2};
                true ->
                    lists:foldl(fun(L, {Cur2, Acc3}) ->
                        if
                            L /= J ->
                                Cost = lists:nth(I+1, Price) -- lists:nth(L+1, Prev),
                                NewCost = lists:nth(L+1, Prev) + hd(Cost),
                                {lists:replace(Cur2, J, NewCost), Acc3};
                            true ->
                                {Cur2, Acc3}
                        end
                    end, {Cur, Acc2}, lists:seq(0, K-1))
            end
        end, {lists:seq(0, K-1), 0}, lists:seq(0, K-1))
    end, {lists:seq(0, K-1), 0}, lists:seq(0, N-1)),
    Result.

lists:nth(Index, List) when is_integer(Index) ->
    lists:nth(Index+1, List).

lists:replace(List, Index, Value) ->
    lists:sublist(List, Index) ++ [Value] ++ lists:sublist(List, Index+1, length(List) - Index).