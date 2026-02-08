-module(solution).
-export([create_sorted_array/1]).

create_sorted_array(Instructions) ->
    create_sorted_array(Instructions, 0, 0, []).

create_sorted_array([], _, Cost, _) ->
    Cost;
create_sorted_array([H | T], Max, Cost, Sorted) ->
    NewMax = lists:max([Max, H]),
    CountLess = length(lists:filter(fun(X) -> X < H end, Sorted)),
    CountGreater = length(Sorted) - CountLess,
    NewCost = Cost + min(CountLess, CountGreater),
    create_sorted_array(T, NewMax, NewCost, lists:insert(H, Sorted)).

lists:insert(X, L) ->
    case lists:foldl(fun(Y, Acc) -> if X < Y -> [X | Acc]; true -> [Y | Acc] end end, [], L) of
        [] -> [X];
        R -> R ++ [X]
    end.