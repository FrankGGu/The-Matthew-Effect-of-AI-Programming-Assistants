-module(minimum_increment_operations).
-export([min_increment_operations/2]).

min_increment_operations(Nums, K) ->
    min_increment_operations(Nums, K, 0, 0, []).

min_increment_operations([], _K, Cost, _Count, _Window) ->
    Cost;
min_increment_operations([Num | Rest], K, Cost, Count, Window) ->
    NewWindow = [Num | Window],
    case length(NewWindow) of
        3 ->
            SortedWindow = lists:sort(NewWindow),
            case lists:nth(1, SortedWindow) < K of
                true ->
                    Diff = K - lists:nth(1, SortedWindow),
                    min_increment_operations(Rest, K, Cost + Diff, 0, []);
                false ->
                    min_increment_operations(Rest, K, Cost, 0, [])
            end;
        _ ->
            min_increment_operations(Rest, K, Cost, Count + 1, NewWindow)
    end.