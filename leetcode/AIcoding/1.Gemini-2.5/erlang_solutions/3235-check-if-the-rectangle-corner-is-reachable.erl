-module(solution).
-export([can_reach_corner/4]).

find(Parents, I) ->
    P_I = element(I + 1, Parents),
    case P_I of
        I -> {I, Parents};
        _ ->
            {Root, NewParents} = find(Parents, P_I),
            {Root, setelement(I + 1, NewParents, Root)}
    end.

union(Parents, I, J) ->
    {RootI, Parents1} = find(Parents, I),
    {RootJ, Parents2} = find(Parents1, J),
    case RootI == RootJ of
        true -> Parents2;
        false -> setelement(RootJ + 1, Parents2, RootI)
    end.

dist_sq(X1, Y1, X2, Y2) ->
    DX = X1 - X2,
    DY = Y1 - Y2,
    DX*DX + DY*DY.

circles_overlap(C1, C2) ->
    {CX1, CY1, R1} = C1,
    {CX2, CY2, R2} = C2,
    R_Sum = R1 + R2,
    dist_sq(CX1, CY1, CX2, CY2) <= R_Sum*R_Sum.

can_reach_corner(Width, Height, Circles) ->
    N = length(Circles),
    NumNodes = N + 4, %% N circles + 4 virtual boundary nodes (left, right, bottom, top)

    %% Initialize DSU parents: each node is its own parent.
    Parents0 = list_to_tuple(lists:seq(0, NumNodes - 1)),

    %% Pre-index circles for easier iteration.
    IndexedCircles = lists:zip(lists:seq(0, N - 1), Circles),

    %% Step 1: Union overlapping circles.
    Parents1 = lists:foldl(
        fun({I, C1}, AccParents) ->
            lists:foldl(
                fun({J, C2}, InnerAccParents) ->
                    case I < J andalso circles_overlap(C1, C2) of
                        true -> union(InnerAccParents, I, J);
                        false -> InnerAccParents
                    end
                end,
                AccParents,
                IndexedCircles
            )
        end,
        Parents0,
        IndexedCircles
    ),

    %% Define indices for virtual boundary nodes.
    LeftIdx = N,
    RightIdx = N + 1,
    BottomIdx = N + 2,
    TopIdx = N + 3,

    %% Step 2: Union circles with boundaries they touch or cross.
    Parents2 = lists:foldl(
        fun({I, {CX, CY, R}}, AccParents) ->
            CurrentParents = AccParents,
            UpdatedParents1 = case CX - R =< 0 of true -> union(CurrentParents, I, LeftIdx); false -> CurrentParents end,
            UpdatedParents2 = case CX + R >= Width of true -> union(UpdatedParents1, I, RightIdx); false -> UpdatedParents1 end,
            UpdatedParents3 = case CY - R =< 0 of true -> union(UpdatedParents2, I, BottomIdx); false -> UpdatedParents2 end,
            UpdatedParents4 = case CY + R >= Height of true -> union(UpdatedParents3, I, TopIdx); false -> UpdatedParents3 end,
            UpdatedParents4
        end,
        Parents1,
        IndexedCircles
    ),

    %% Step 3: Check connectivity of boundaries.
    %% The corner is reachable if there's no path of circles connecting
    %% the left boundary to the right boundary, AND no path connecting
    %% the bottom boundary to the top boundary.
    {LeftRoot, _} = find(Parents2, LeftIdx),
    {RightRoot, _} = find(Parents2, RightIdx),
    {BottomRoot, _} = find(Parents2, BottomIdx),
    {TopRoot, _} = find(Parents2, TopIdx),

    not (LeftRoot == RightRoot orelse BottomRoot == TopRoot).