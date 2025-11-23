-module(minimum_cost_path).
-export([minimum_cost/1]).

minimum_cost(Grid) ->
    {M, N} = {length(Grid), length(hd(Grid))},
    Dist = array:new([{1, M}, {1, N}], infinity),
    array:set({1, 1}, 0, Dist),
    PQ = gb_sets:from_list([{0, 1, 1}]),

    Directions = [{1, 0, 1}, {2, 0, -1}, {3, 1, 0}, {4, -1, 0}],

    process_pq(Grid, M, N, Dist, PQ, Directions).

process_pq(Grid, M, N, Dist, PQ, Directions) ->
    case gb_sets:is_empty(PQ) of
        true ->
            array:get({M, N}, Dist);
        false ->
            {_, {D, X, Y}} = gb_sets:take_smallest(PQ),
            PQ1 = gb_sets:delete({D, X, Y}, PQ),

            case D > array:get({X, Y}, Dist) of
                true ->
                    process_pq(Grid, M, N, Dist, PQ1, Directions);
                false ->
                    Val = lists:nth(Y, lists:nth(X, Grid)),
                    NewPQ = fold_directions(Grid, M, N, Dist, PQ1, X, Y, Val, Directions),
                    process_pq(Grid, M, N, Dist, NewPQ, Directions)
            end
    end.

fold_directions(Grid, M, N, Dist, PQ, X, Y, Val, Directions) ->
    lists:foldl(fun({Dir, DX, DY}, Acc) ->
                        XX = X + DX,
                        YY = Y + DY,
                        case (XX >= 1) and (XX =< M) and (YY >= 1) and (YY =< N) of
                            true ->
                                Cost = case Dir =:= Val of
                                           true -> 0;
                                           false -> 1
                                       end,
                                NewDist = array:get({X, Y}, Dist) + Cost,
                                if NewDist < array:get({XX, YY}, Dist) then
                                    array:set({XX, YY}, NewDist, Dist),
                                    gb_sets:add({NewDist, XX, YY}, Acc)
                                else
                                    Acc
                                end;
                            false ->
                                Acc
                        end
                end, PQ, Directions).