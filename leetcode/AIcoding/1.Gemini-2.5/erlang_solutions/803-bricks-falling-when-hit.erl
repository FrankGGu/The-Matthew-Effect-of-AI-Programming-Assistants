-module(solution).
-export([bricksFallingWhenHit/2]).

-define(CEILING_NODE(MaxR, MaxC), (MaxR * MaxC)).

cell_idx(R, C, MaxC) ->
    R * MaxC + C.

find(Node, Parents) ->
    case maps:find(Node, Parents) of
        error ->
            %% Node not in Parents map, it's a root (or new node to be added)
            {Node, Parents};
        {ok, Parent} when Parent == Node ->
            %% Node is its own parent, it's a root
            {Node, Parents};
        {ok, Parent} ->
            %% Path compression
            {Root, NewParents} = find(Parent, Parents),
            {Root, maps:put(Node, Root, NewParents)}
    end.

union(Node1, Node2, Parents, Sizes) ->
    {Root1, Parents1} = find(Node1, Parents),
    {Root2, Parents2} = find(Node2, Parents1),

    if Root1 == Root2 ->
            {Parents2, Sizes};
        true ->
            Size1 = maps:get(Root1, Sizes, 1), %% Default size 1 for a new root
            Size2 = maps:get(Root2, Sizes, 1),

            if Size1 < Size2 ->
                    NewParents = maps:put(Root1, Root2, Parents2),
                    NewSizes = maps:put(Root2, Size1 + Size2, maps:remove(Root1, Sizes));
                true ->
                    NewParents = maps:put(Root2, Root1, Parents2),
                    NewSizes = maps:put(Root1, Size1 + Size2, maps:remove(Root2, Sizes))
            end,
            {NewParents, NewSizes}
    end.

init_dsu(GridMap, MaxR, MaxC) ->
    Parents0 = #{},
    Sizes0 = #{},

    %% Add ceiling node
    CeilingNode = ?CEILING_NODE(MaxR, MaxC),
    Parents1 = maps:put(CeilingNode, CeilingNode, Parents0),
    Sizes1 = maps:put(CeilingNode, 0, Sizes0), %% Ceiling size is 0 initially (no bricks yet)

    %% Add all bricks as individual sets
    lists:foldl(
        fun({{R, C}, Val}, {AccParents, AccSizes}) ->
            Idx = cell_idx(R, C, MaxC),
            AccParents2 = maps:put(Idx, Idx, AccParents),
            AccSizes2 = maps:put(Idx, 1, AccSizes),
            {AccParents2, AccSizes2}
        end, {Parents1, Sizes1}, maps:to_list(GridMap)
    ).

connect_bricks(GridMap, MaxR, MaxC, Parents, Sizes) ->
    CeilingNode = ?CEILING_NODE(MaxR, MaxC),
    lists:foldl(
        fun({{R, C}, Val}, {AccParents, AccSizes}) ->
            if Val == 1 ->
                Idx = cell_idx(R, C, MaxC),
                {CurrentParents, CurrentSizes} = {AccParents, AccSizes},

                %% Connect to ceiling if in first row
                {ParentsA, SizesA} = if R == 0 ->
                                        union(Idx, CeilingNode, CurrentParents, CurrentSizes);
                                    true ->
                                        {CurrentParents, CurrentSizes}
                                 end,

                %% Connect to neighbors
                Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],
                lists:foldl(
                    fun({NR, NC}, {P, S}) ->
                        if NR >= 0 andalso NR < MaxR andalso NC >= 0 andalso NC < MaxC andalso maps:get({NR, NC}, GridMap, 0) == 1 ->
                            NIdx = cell_idx(NR, NC, MaxC),
                            union(Idx, NIdx, P, S);
                        true ->
                            {P, S}
                        end
                    end, {ParentsA, SizesA}, Neighbors
                );
            true ->
                {AccParents, AccSizes}
            end
        end, {Parents, Sizes}, maps:to_list(GridMap)
    ).

get_ceiling_component_size(Parents, Sizes, MaxR, MaxC) ->
    CeilingNode = ?CEILING_NODE(MaxR, MaxC),
    {CeilingRoot, _} = find(CeilingNode, Parents),
    maps:get(CeilingRoot, Sizes, 0).

bricksFallingWhenHit(Grid, Hits) ->
    MaxR = length(Grid),
    MaxC = length(hd(Grid)),

    %% Convert grid to map for easier updates
    GridMap0 = list_to_grid_map(Grid, MaxR, MaxC),

    %% Mark hit positions as 0 in a temporary grid map
    %% Also store original values at hit positions
    {GridMapAfterHits, OriginalHitValues} = lists:foldl(
        fun({R, C}, {AccGridMap, AccOriginalHitValues}) ->
            Val = maps:get({R, C}, AccGridMap, 0),
            {maps:put({R, C}, 0, AccGridMap), [{R, C, Val} | AccOriginalHitValues]}
        end, {GridMap0, []}, Hits
    ),
    OriginalHitValuesReversed = lists:reverse(OriginalHitValues),

    %% Initialize DSU for the grid *after* all hits are applied
    {Parents0, Sizes0} = init_dsu(GridMapAfterHits, MaxR, MaxC),
    {Parents1, Sizes1} = connect_bricks(GridMapAfterHits, MaxR, MaxC, Parents0, Sizes0),

    %% Process hits in reverse order
    CeilingNode = ?CEILING_NODE(MaxR, MaxC),
    {ResultsReversed, _, _, _} = lists:foldl(
        fun({R, C, OriginalVal}, {AccResults, AccParents, AccSizes, AccGridMap}) ->
            if OriginalVal == 0 ->
                %% No brick was there originally, no bricks fall
                {[0 | AccResults], AccParents, AccSizes, AccGridMap};
            true ->
                %% A brick was there, add it back
                Idx = cell_idx(R, C, MaxC),

                %% Get current ceiling component size BEFORE adding this brick
                PrevCeilingSize = get_ceiling_component_size(AccParents, AccSizes, MaxR, MaxC),

                %% Add the brick back to the grid map
                AccGridMap1 = maps:put({R, C}, 1, AccGridMap),

                %% Add the brick to DSU as a new set (or ensure it's in Parents/Sizes)
                AccParents2 = maps:put(Idx, Idx, AccParents),
                AccSizes2 = maps:put(Idx, 1, AccSizes),

                %% Connect the added brick to its neighbors and ceiling if applicable
                {ParentsA, SizesA} = if R == 0 ->
                                        union(Idx, CeilingNode, AccParents2, AccSizes2);
                                    true ->
                                        {AccParents2, AccSizes2}
                                 end,

                Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],
                {NewParents, NewSizes} = lists:foldl(
                    fun({NR, NC}, {P, S}) ->
                        if NR >= 0 andalso NR < MaxR andalso NC >= 0 andalso NC < MaxC andalso maps:get({NR, NC}, AccGridMap1, 0) == 1 ->
                            NIdx = cell_idx(NR, NC, MaxC),
                            union(Idx, NIdx, P, S);
                        true ->
                            {P, S}
                        end
                    end, {ParentsA, SizesA}, Neighbors
                ),

                %% Get new ceiling component size AFTER adding this brick
                CurrCeilingSize = get_ceiling_component_size(NewParents, NewSizes, MaxR, MaxC),

                FallenBricks = max(0, CurrCeilingSize - PrevCeilingSize - 1), %% Subtract 1 because the brick itself didn't fall
                {[FallenBricks | AccResults], NewParents, NewSizes, AccGridMap1}
            end
        end, {[], Parents1, Sizes1, GridMapAfterHits}, OriginalHitValuesReversed
    ),
    lists:reverse(ResultsReversed).

list_to_grid_map(Grid, MaxR, MaxC) ->
    lists:foldl(
        fun(R_idx, AccMapR) ->
            Row = lists:nth(R_idx + 1, Grid),
            lists:foldl(
                fun(C_idx, AccMapC) ->
                    Val = lists:nth(C_idx + 1, Row),
                    maps:put({R_idx, C_idx}, Val, AccMapC)
                end, AccMapR, lists:seq(0, MaxC - 1)
            )
        end, #{}, lists:seq(0, MaxR - 1)
    ).