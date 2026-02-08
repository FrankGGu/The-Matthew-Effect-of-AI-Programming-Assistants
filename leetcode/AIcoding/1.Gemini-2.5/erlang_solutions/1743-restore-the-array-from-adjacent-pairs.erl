-module(solution).
-export([restore_array/1]).

restore_array(AdjacentPairs) ->
    AdjMap = build_adj_map(AdjacentPairs),
    N = maps:size(AdjMap),
    Start = find_start_node(AdjMap),
    restore(Start, undefined, AdjMap, [], 0, N).

build_adj_map(Pairs) ->
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = maps:update_with(U, fun(Val) -> [V | Val] end, [V], Acc),
        maps:update_with(V, fun(Val) -> [U | Val] end, [U], Acc1)
    end, #{}, Pairs).

find_start_node(AdjMap) ->
    maps:fold(fun(K, Neighbors, Acc) ->
        case length(Neighbors) of
            1 -> K;
            _ -> Acc
        end
    end, undefined, AdjMap).

restore(Current, Previous, AdjMap, Acc, Count, N) ->
    NewAcc = [Current | Acc],
    NewCount = Count + 1,
    if
        NewCount == N -> lists:reverse(NewAcc);
        true ->
            Neighbors = maps:get(Current, AdjMap),
            Next = case Neighbors of
                [Neighbor] -> Neighbor;
                [N1, N2] when N1 == Previous -> N2;
                [N1, N2] when N2 == Previous -> N1
            end,
            restore(Next, Current, AdjMap, NewAcc, NewCount, N)
    end.