-module(solution).
-export([distantBarcodes/1]).

distantBarcodes(Barcodes) ->
    Counts = lists:foldl(fun(Barcode, Acc) ->
        case lists:keyfind(Barcode, 1, Acc) of
            false -> [{Barcode, 1} | Acc];
            {Barcode, Count} -> lists:keyreplace(Barcode, 1, Acc, {Barcode, Count + 1})
        end
    end, [], Barcodes),
    SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A > B end, Counts),
    Result = lists:foldl(fun({Barcode, Count}, Acc) ->
        lists:append(Acc, lists:duplicate(Count, Barcode))
    end, [], SortedCounts),
    Result1 = lists:map(fun(X) -> X end, Result),
    fill(Result1, []).

fill([], Acc) -> Acc;
fill([H | T], Acc) ->
    case Acc of
        [] -> fill(T, [H]);
        [H1 | T1] when H =/= H1 -> fill(T, [H, H1 | T1]);
        _ -> fill(T, Acc ++ [H])
    end.