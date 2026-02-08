-module(solution).
-export([is_possible/2]).

is_possible(N, Edges) ->
    Degrees = array:new([{size, N + 1}, {default, 0}]),
    Adj = array:new([{size, N + 1}, {default, gb_sets:new()}]),

    {FinalDegrees, FinalAdj} = lists:foldl(
        fun([U, V], {CurrentDegrees, CurrentAdj}) ->
            NewDegrees1 = array:set(U, array:get(U, CurrentDegrees) + 1, CurrentDegrees),
            NewDegrees2 = array:set(V, array:get(V, NewDegrees1) + 1, NewDegrees1),

            AdjU = array:get(U, CurrentAdj),
            AdjV = array:get(V, CurrentAdj),
            NewAdj1 = array:set(U, gb_sets:add(V, AdjU), CurrentAdj),
            NewAdj2 = array:set(V, gb_sets:add(U, array:get(V, NewAdj1)), NewAdj1),

            {NewDegrees2, NewAdj2}
        end,
        {Degrees, Adj},
        Edges
    ),

    OddNodes = collect_odd_nodes(1, N, FinalDegrees, []),

    case length(OddNodes) of
        0 -> true;
        2 ->
            [U, V] = OddNodes,
            AdjU = array:get(U, FinalAdj),
            AdjV = array:get(V, FinalAdj),

            case gb_sets:is_member(V, AdjU) of
                false -> true;
                true ->
                    find_suitable_X(1, N, AdjU, AdjV)
            end;
        4 ->
            [A, B, C, D] = OddNodes,
            AdjA = array:get(A, FinalAdj),
            AdjB = array:get(B, FinalAdj),
            AdjC = array:get(C, FinalAdj),
            AdjD = array:get(D, FinalAdj),

            (not gb_sets:is_member(B, AdjA) andalso not gb_sets:is_member(D, AdjC)) orelse
            (not gb_sets:is_member(C, AdjA) andalso not gb_sets:is_member(D, AdjB)) orelse
            (not gb_sets:is_member(D, AdjA) andalso not gb_sets:is_member(C, AdjB));
        _ ->
            false
    end.

collect_odd_nodes(I, N, Degrees, Acc) when I > N ->
    lists:reverse(Acc);
collect_odd_nodes(I, N, Degrees, Acc) ->
    Degree = array:get(I, Degrees),
    case Degree rem 2 of
        1 -> collect_odd_nodes(I + 1, N, Degrees, [I | Acc]);
        0 -> collect_odd_nodes(I + 1, N, Degrees, Acc)
    end.

find_suitable_X(CurrentX, MaxX, AdjU, AdjV) when CurrentX > MaxX ->
    false;
find_suitable_X(CurrentX, MaxX, AdjU, AdjV) ->
    case not gb_sets:is_member(CurrentX, AdjU) andalso not gb_sets:is_member(CurrentX, AdjV) of
        true -> true;
        false -> find_suitable_X(CurrentX + 1, MaxX, AdjU, AdjV)
    end.