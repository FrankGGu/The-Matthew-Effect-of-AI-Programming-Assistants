-module(distant_barcodes).
-export([reorganize_barcode/1]).

reorganize_barcode(Barcode) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Barcode),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Count)),
    Result = reorganize(Sorted, []),
    lists:reverse(Result).

reorganize([], Acc) ->
    Acc;
reorganize([{Val, Count} | Rest], Acc) ->
    case Acc of
        [] ->
            reorganize(Rest, [Val | Acc]);
        [Last | _] when Val == Last ->
            reorganize(Rest, [Val | Acc]);
        _ ->
            reorganize(Rest, [Val | Acc])
    end.