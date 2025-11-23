-module(skyline).
-export([get_skyline/1]).

get_skyline(Buildings) ->
    Points = lists:flatmap(fun([L, R, H]) -> 
                              [{L, -H}, {R, H}]
                           end, Buildings),
    SortedPoints = lists:keysort(1, Points),
    process_points(SortedPoints, {0, gb_trees:empty()}, []).

process_points([], {_, Heap}, Result) ->
    lists:reverse(Result);
process_points([{X, H} | Rest], {MaxH, Heap}, Result) ->
    case H < 0 of
        true ->
            NewHeap = case gb_trees:lookup(-H, Heap) of
                          none -> gb_trees:enter(-H, 1, Heap);
                          {value, Count} -> gb_trees:update(-H, Count + 1, Heap)
                      end,
            NewMaxH = case gb_trees:is_empty(NewHeap) of
                          true -> 0;
                          false -> gb_trees:largest(NewHeap)
                      end,
            if
                NewMaxH > MaxH ->
                    process_points(Rest, {NewMaxH, NewHeap}, [{X, NewMaxH} | Result]);
                true ->
                    process_points(Rest, {MaxH, NewHeap}, Result)
            end;
        false ->
            {value, Count} = gb_trees:lookup(H, Heap),
            NewHeap = if
                          Count =:= 1 -> gb_trees:delete(H, Heap);
                          true -> gb_trees:update(H, Count - 1, Heap)
                      end,
            NewMaxH = case gb_trees:is_empty(NewHeap) of
                          true -> 0;
                          false -> gb_trees:largest(NewHeap)
                      end,
            if
                NewMaxH < MaxH ->
                    process_points(Rest, {NewMaxH, NewHeap}, [{X, NewMaxH} | Result]);
                true ->
                    process_points(Rest, {MaxH, NewHeap}, Result)
            end
    end.