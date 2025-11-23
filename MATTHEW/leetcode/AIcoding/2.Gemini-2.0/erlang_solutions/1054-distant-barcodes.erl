-module(distant_barcodes).
-export([rearrange_barcodes/1]).

rearrange_barcodes(Barcodes) ->
  Counts = lists:foldl(fun(X, Acc) ->
                              maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                          end, #{}, Barcodes),
  SortedCounts = lists:sort(fun({_, C1}, {_, C2}) -> C1 > C2 end, maps:to_list(Counts)),
  rearrange(SortedCounts, length(Barcodes)).

rearrange(SortedCounts, Len) ->
  rearrange(SortedCounts, [], Len, []).

rearrange([], Acc, 0, Result) ->
  lists:reverse(Result);
rearrange([], Acc, Len, Result) ->
  rearrange(Acc, [], Len, Result);
rearrange([{Barcode, Count} | Rest], Acc, Len, Result) ->
  if
    Len > 0 ->
      rearrange(
        case Count - 1 of
          0 -> Rest;
          N -> [{Barcode, N} | Rest]
        end,
        [ {Barcode, Count - 1} | Acc ],
        Len - 1,
        [Barcode | Result]
      );
    true ->
      lists:reverse(Result)
  end.