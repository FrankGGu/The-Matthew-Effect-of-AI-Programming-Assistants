-module(solution).
-export([largestColorValue/2]).

largestColorValue(Colors, Edges) ->
    N = length(Colors),
    ColorList = string:to_list(Colors),

    Adj = array:new([{fixed, true}, {size, N}, {default, []}]),
    InDegree = array:new([{fixed, true}, {size, N}, {default, 0}]),

    {FinalAdj, FinalInDegree} = lists:foldl(fun([U, V], {AccAdj, AccInDegree}) ->
        AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
        AccInDegree1 = array:set(V, array:get(V, AccInDegree) + 1, AccInDegree),
        {AccAdj1, AccInDegree1}
    end, {Adj, InDegree}, Edges),

    DP = array:new([{fixed, true}, {size, N}, {default, list_of_zeros(26)}]),
    InitialDP = lists:foldl(fun(I, AccDP) ->
        ColorChar = lists:nth(I + 1, ColorList),
        ColorIdx = ColorChar - $a,
        CurrentCounts = array:get(I, AccDP),
        UpdatedCounts = lists:replace_at(ColorIdx + 1, 1, CurrentCounts),
        array:set(I, UpdatedCounts, AccDP)
    end, DP, lists:seq(0, N - 1)),

    Q = queue:new(),
    InitialQ = lists:foldl(fun(I, AccQ) ->
        case array:get(I, FinalInDegree) of
            0 -> queue:in(I, AccQ);
            _ -> AccQ
        end
    end, Q, lists:seq(0, N - 1)),

    InitialMaxColorValue = 0,

    {_, _, FinalVisitedNodes, FinalMaxColorValue} =
        topological_sort(InitialQ, FinalAdj, FinalInDegree, InitialDP, 0, InitialMaxColorValue, ColorList),

    case FinalVisitedNodes == N of
        true -> FinalMaxColorValue;
        false -> -1
    end.

topological_sort(Q, Adj, InDegree, DP, VisitedNodes, MaxColorValue, ColorList) ->
    case queue:is_empty(Q) of
        true ->
            {Q, DP, VisitedNodes, MaxColorValue};
        false ->
            {{value, U}, Q1} = queue:out(Q),
            CurrentVisitedNodes = VisitedNodes + 1,

            U_DP_Counts = array:get(U, DP),

            CurrentMaxColorValue = lists:max(U_DP_Counts),
            NewMaxColorValue = max(MaxColorValue, CurrentMaxColorValue),

            Neighbors = array:get(U, Adj),
            {Q2, DP1, InDegree1} =
                lists:foldl(fun(V, {AccQ, AccDP, AccInDegree}) ->
                    V_Color_Char = lists:nth(V + 1, ColorList),
                    V_Color_Idx = V_Color_Char - $a,

                    V_DP_Counts = array:get(V, AccDP),
                    New_V_DP_Counts = update_neighbor_dp(V_DP_Counts, U_DP_Counts, V_Color_Idx),
                    AccDP1 = array:set(V, New_V_DP_Counts, AccDP),

                    V_InDegree = array:get(V, AccInDegree),
                    New_V_InDegree = V_InDegree - 1,
                    AccInDegree1 = array:set(V, New_V_InDegree, AccInDegree),

                    case New_V_InDegree of
                        0 -> {queue:in(V, AccQ), AccDP1, AccInDegree1};
                        _ -> {AccQ, AccDP1, AccInDegree1}
                    end
                end, {Q1, DP, InDegree}, Neighbors),

            topological_sort(Q2, Adj, InDegree1, DP1, CurrentVisitedNodes, NewMaxColorValue, ColorList)
    end.

list_of_zeros(N) ->
    lists:duplicate(N, 0).

update_neighbor_dp(V_DP_Counts, U_DP_Counts, V_Color_Idx) ->
    lists:foldl(fun(Color_Idx, AccV_DP_Counts) ->
        U_Count_For_Color = lists:nth(Color_Idx + 1, U_DP_Counts),
        Current_V_Count_For_Color = lists:nth(Color_Idx + 1, AccV_DP_Counts),

        Count_From_U_Path = U_Count_For_Color,
        New_Count_From_U =
            case Color_Idx == V_Color_Idx of
                true -> Count_From_U_Path + 1;
                false -> Count_From_U_Path
            end,

        lists:replace_at(Color_Idx + 1, max(Current_V_Count_For_Color, New_Count_From_U), AccV_DP_Counts)
    end, V_DP_Counts, lists:seq(0, 25)).