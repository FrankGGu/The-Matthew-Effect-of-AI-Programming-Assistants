-module(solution).
-export([total_cost/3]).

total_cost(Costs, K, Candidates) ->
    N = length(Costs),
    CostsMap = build_costs_map(Costs, N),

    InitialLeftPQ = gb_trees:empty(),
    InitialRightPQ = gb_trees:empty(),

    {LeftPQ1, LeftPtr1} = fill_left_pq(InitialLeftPQ, CostsMap, 0, N - 1, Candidates),
    {RightPQ1, RightPtr1} = fill_right_pq(InitialRightPQ, CostsMap, LeftPtr1, N - 1, Candidates),

    hire_loop(K, LeftPQ1, RightPQ1, LeftPtr1, RightPtr1, CostsMap, 0).

build_costs_map(Costs, N) ->
    build_costs_map_recursive(Costs, 0, N, gb_trees:empty()).

build_costs_map_recursive([], _Idx, _N, AccMap) -> AccMap;
build_costs_map_recursive([H|T], Idx, N, AccMap) when Idx < N ->
    build_costs_map_recursive(T, Idx + 1, N, gb_trees:insert(Idx, H, AccMap)).

fill_left_pq(PQ, CostsMap, CurrentLeftPtr, CurrentRightPtr, Count) when Count > 0 ->
    if CurrentLeftPtr =< CurrentRightPtr ->
        Cost = gb_trees:get(CurrentLeftPtr, CostsMap),
        NewPQ = gb_trees:insert({Cost, CurrentLeftPtr}, PQ),
        fill_left_pq(NewPQ, CostsMap, CurrentLeftPtr + 1, CurrentRightPtr, Count - 1);
    true ->
        {PQ, CurrentLeftPtr}
    end;
fill_left_pq(PQ, _CostsMap, CurrentLeftPtr, _CurrentRightPtr, _Count) ->
    {PQ, CurrentLeftPtr}.

fill_right_pq(PQ, CostsMap, CurrentLeftPtr, CurrentRightPtr, Count) when Count > 0 ->
    if CurrentLeftPtr =< CurrentRightPtr ->
        Cost = gb_trees:get(CurrentRightPtr, CostsMap),
        NewPQ = gb_trees:insert({Cost, CurrentRightPtr}, PQ),
        fill_right_pq(NewPQ, CostsMap, CurrentLeftPtr, CurrentRightPtr - 1, Count - 1);
    true ->
        {PQ, CurrentRightPtr}
    end;
fill_right_pq(PQ, _CostsMap, _CurrentLeftPtr, CurrentRightPtr, _Count) ->
    {PQ, CurrentRightPtr}.

hire_loop(0, _LeftPQ, _RightPQ, _LeftPtr, _RightPtr, _CostsMap, TotalCost) ->
    TotalCost;
hire_loop(K, LeftPQ, RightPQ, LeftPtr, RightPtr, CostsMap, CurrentTotalCost) ->
    LeftEmpty = gb_trees:is_empty(LeftPQ),
    RightEmpty = gb_trees:is_empty(RightPQ),

    {ChosenCost, NewLeftPQ, NewRightPQ, NewLeftPtr, NewRightPtr} = 
        if LeftEmpty and RightEmpty ->
            %% This case should ideally not be reached if K <= N,
            %% as there would be no workers left to hire.
            {0, LeftPQ, RightPQ, LeftPtr, RightPtr}; 
        LeftEmpty ->
            {{Cost, _Idx}, TempRightPQ} = gb_trees:take_smallest(RightPQ),
            {Cost, LeftPQ, 
             if LeftPtr =< RightPtr ->
                gb_trees:insert({gb_trees:get(RightPtr, CostsMap), RightPtr}, TempRightPQ);
             true ->
                TempRightPQ
             end,
             LeftPtr, 
             if LeftPtr =< RightPtr -> RightPtr - 1; true -> RightPtr end};
        RightEmpty ->
            {{Cost, _Idx}, TempLeftPQ} = gb_trees:take_smallest(LeftPQ),
            {Cost, 
             if LeftPtr =< RightPtr ->
                gb_trees:insert({gb_trees:get(LeftPtr, CostsMap), LeftPtr}, TempLeftPQ);
             true ->
                TempLeftPQ
             end,
             RightPQ, 
             if LeftPtr =< RightPtr -> LeftPtr + 1; true -> LeftPtr end,
             RightPtr};
        true -> %% Both PQs are not empty
            {{CostL, IdxL}, _} = gb_trees:smallest(LeftPQ),
            {{CostR, IdxR}, _} = gb_trees:smallest(RightPQ),

            if CostL =< CostR ->
                if CostL == CostR and IdxL > IdxR -> %% Tie-breaker: pick from right (smaller index)
                    {{Cost, _Idx}, TempRightPQ} = gb_trees:take_smallest(RightPQ),
                    {Cost, LeftPQ, 
                     if LeftPtr =< RightPtr ->
                        gb_trees:insert({gb_trees:get(RightPtr, CostsMap), RightPtr}, TempRightPQ);
                     true ->
                        TempRightPQ
                     end,
                     LeftPtr, 
                     if LeftPtr =< RightPtr -> RightPtr - 1; true -> RightPtr end};
                true -> %% Pick from left
                    {{Cost, _Idx}, TempLeftPQ} = gb_trees:take_smallest(LeftPQ),
                    {Cost, 
                     if LeftPtr =< RightPtr ->
                        gb_trees:insert({gb_trees:get(LeftPtr, CostsMap), LeftPtr}, TempLeftPQ);
                     true ->
                        TempLeftPQ
                     end,
                     RightPQ, 
                     if LeftPtr =< RightPtr -> LeftPtr + 1; true -> LeftPtr end,
                     RightPtr
                end;
            true -> %% CostL > CostR, pick from right
                {{Cost, _Idx}, TempRightPQ} = gb_trees:take_smallest(RightPQ),
                {Cost, LeftPQ, 
                 if LeftPtr =< RightPtr ->
                    gb_trees:insert({gb_trees:get(RightPtr, CostsMap), RightPtr}, TempRightPQ);
                 true ->
                    TempRightPQ
                 end,
                 LeftPtr, 
                 if LeftPtr =< RightPtr -> RightPtr - 1; true -> RightPtr end
            end
        end,

    hire_loop(K - 1, NewLeftPQ, NewRightPQ, NewLeftPtr, NewRightPtr, CostsMap, CurrentTotalCost + ChosenCost).