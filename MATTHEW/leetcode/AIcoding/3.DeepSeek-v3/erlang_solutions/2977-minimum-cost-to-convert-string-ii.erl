-module(solution).
-export([minimum_cost/5]).

minimum_cost(Source, Target, Original, Changed, Cost) ->
    {Nodes, NodeMap} = build_node_map(Original, Changed),
    Dist = floyd_warshall(Nodes, NodeMap, Original, Changed, Cost),
    calculate_cost(Source, Target, Dist, NodeMap, 0).

build_node_map(Original, Changed) ->
    All = lists:usort(Original ++ Changed),
    NodeMap = maps:from_list(lists:zip(All, lists:seq(0, length(All) - 1)),
    {All, NodeMap}.

floyd_warshall(Nodes, NodeMap, Original, Changed, Cost) ->
    Size = length(Nodes),
    Dist = array:new([{size, Size}, {default, array:new([{size, Size}, {default, infinity}])}]),
    Dist1 = lists:foldl(fun(I, D) -> array:set(I, array:set(I, 0, array:get(I, D)), D) end, Dist, lists:seq(0, Size - 1)),
    Dist2 = lists:foldl(fun({O, C, W}, D) ->
        U = maps:get(O, NodeMap),
        V = maps:get(C, NodeMap),
        Old = array:get(U, array:get(V, D)),
        case W < Old of
            true -> 
                Row = array:get(U, D),
                NewRow = array:set(V, W, Row),
                array:set(U, NewRow, D);
            false -> D
        end
    end, Dist1, lists:zip3(Original, Changed, Cost)),
    lists:foldl(fun(K, D) ->
        lists:foldl(fun(I, D1) ->
            lists:foldl(fun(J, D2) ->
                IK = array:get(I, array:get(K, D2)),
                KJ = array:get(K, array:get(J, D2)),
                IJ = array:get(I, array:get(J, D2)),
                case IK + KJ < IJ of
                    true ->
                        Row = array:get(I, D2),
                        NewRow = array:set(J, IK + KJ, Row),
                        array:set(I, NewRow, D2);
                    false -> D2
                end
            end, D1, lists:seq(0, Size - 1))
        end, D, lists:seq(0, Size - 1))
    end, Dist2, lists:seq(0, Size - 1)).

calculate_cost([], [], _, _, Acc) -> Acc;
calculate_cost([S | Ss], [T | Ts], Dist, NodeMap, Acc) ->
    case S =:= T of
        true -> calculate_cost(Ss, Ts, Dist, NodeMap, Acc);
        false ->
            U = maps:get([S], NodeMap),
            V = maps:get([T], NodeMap),
            case array:get(U, array:get(V, Dist)) of
                infinity -> -1;
                Cost -> calculate_cost(Ss, Ts, Dist, NodeMap, Acc + Cost)
            end
    end.