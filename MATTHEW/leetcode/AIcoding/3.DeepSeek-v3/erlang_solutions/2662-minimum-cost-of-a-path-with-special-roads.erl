-module(solution).
-export([minimum_cost/1]).

minimum_cost(StartAndTarget) ->
    {Start, Target} = case StartAndTarget of
        [[SX, SY], [TX, TY]] -> {{SX, SY}, {TX, TY}};
        _ -> {{0, 0}, {0, 0}}
    end,
    SpecialRoads = case StartAndTarget of
        [_, _, Roads] -> Roads;
        _ -> []
    end,
    Heap = heap:new(),
    Heap1 = heap:insert(Heap, {0, Start}),
    Visited = sets:new(),
    solve(Heap1, Visited, Target, SpecialRoads).

solve(Heap, Visited, Target, SpecialRoads) ->
    case heap:is_empty(Heap) of
        true -> 0;
        false ->
            {{Cost, {X, Y}}, Heap1} = heap:take(Heap),
            case {X, Y} of
                Target -> Cost;
                _ ->
                    case sets:is_element({X, Y}, Visited) of
                        true -> solve(Heap1, Visited, Target, SpecialRoads);
                        false ->
                            Visited1 = sets:add_element({X, Y}, Visited),
                            Heap2 = add_normal_move(Heap1, X, Y, Target, Cost, Visited1),
                            Heap3 = add_special_moves(Heap2, X, Y, SpecialRoads, Cost, Visited1),
                            solve(Heap3, Visited1, Target, SpecialRoads)
                    end
            end
    end.

add_normal_move(Heap, X, Y, {TX, TY}, Cost, Visited) ->
    NewCost = Cost + abs(TX - X) + abs(TY - Y),
    case sets:is_element({TX, TY}, Visited) of
        false -> heap:insert(Heap, {NewCost, {TX, TY}});
        true -> Heap
    end.

add_special_moves(Heap, X, Y, SpecialRoads, Cost, Visited) ->
    lists:foldl(fun([X1, Y1, X2, Y2, SC], AccHeap) ->
        case sets:is_element({X2, Y2}, Visited) of
            false ->
                NewCost = Cost + abs(X1 - X) + abs(Y1 - Y) + SC,
                heap:insert(AccHeap, {NewCost, {X2, Y2}});
            true -> AccHeap
        end
    end, Heap, SpecialRoads).