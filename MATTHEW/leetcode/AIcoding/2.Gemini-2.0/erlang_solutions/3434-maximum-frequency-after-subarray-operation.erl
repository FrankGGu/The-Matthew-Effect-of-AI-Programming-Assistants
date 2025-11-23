-module(max_frequency).
-export([find_max_frequency/2]).

find_max_frequency(Nums, K) ->
    find_max_frequency(Nums, K, 0, 0, 0, []).

find_max_frequency(Nums, K, Left, Right, MaxFreq, Window) ->
    case Right < length(Nums) of
        true ->
            Num = lists:nth(Right + 1, Nums),
            NewWindow = lists:sort(Window ++ [Num]),
            Sum = lists:sum(NewWindow),
            Len = length(NewWindow),
            Cost = Len * lists:last(NewWindow) - Sum,
            case Cost =< K of
                true ->
                    NewMaxFreq = max(MaxFreq, Len),
                    find_max_frequency(Nums, K, Left, Right + 1, NewMaxFreq, NewWindow);
                false ->
                    First = lists:nth(Left + 1, Nums),
                    find_max_frequency(Nums, K, Left + 1, Right, MaxFreq, lists:delete(First, NewWindow))
            end;
        false ->
            MaxFreq
    end.