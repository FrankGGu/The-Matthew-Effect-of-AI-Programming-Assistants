-module(solution).
-export([good_paths/2]).

good_paths(Vals, Edges) ->
    N = length(Vals),
    Ans = N, % Each node itself is a good path (e.g., path from 0 to 0)

    % Initialize DSU parent array
    Parent0 = array:new(N, {default, 0}),
    Parent = initialize_parent(Parent0, N),

    % Convert Vals to an array for O(1) access
    ValsArr = array:from_list(Vals),

    % Build adjacency list
    Adj0 = array:new(N, {default, []}),
    Adj = lists:foldl(fun([U, V], AccAdj) ->
                              AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
                              array:set(V, [U | array:get(V, AccAdj1)], AccAdj1)
                      end, Adj0, Edges),

    % Group nodes by value
    NodesByValue = lists:foldl(fun(I, AccMap) ->
                                       Val = array:get(I, ValsArr),
                                       maps:update_with(Val, fun(L) -> [I | L] end, [I], AccMap)
                               end, maps:new(), lists:seq(0, N - 1)),

    % Sort unique values to process nodes in increasing order of value
    UniqueValues = lists:sort(maps:keys(NodesByValue)),

    % State for the fold: {CurrentAns, CurrentParentArray}
    {FinalAns, _} = lists:foldl(fun(V, {CurrentAns, CurrentParent}) ->
                                        NodesInCurrentGroup = maps:get(V, NodesByValue),

                                        % ValCountsForGroup tracks counts of nodes with value V for roots
                                        % This map is local to the current V iteration
                                        ValCountsForGroup0 = maps:new(),
                                        {ValCountsForGroup1, ParentAfterFinds} = lists:foldl(fun(IU, {AccVCFG, AccParent}) ->
                                                                                                      {NewParent, RootIU} = find(AccParent, IU),
                                                                                                      {maps:update_with(RootIU, fun(C) -> C + 1 end, 1, AccVCFG), NewParent}
                                                                                              end, {ValCountsForGroup0, CurrentParent}, NodesInCurrentGroup),

                                        {NewAns, NewParentAfterUnions, _FinalVCFG} = lists:foldl(fun(IU, {AccAns, AccParent, AccVCFG}) ->
                                                                                                        {ParentAfterPathCompression, RootIU} = find(AccParent, IU),
                                                                                                        Neighbors = array:get(IU, Adj),

                                                                                                        {InnerAccAns, InnerAccParent, InnerAccVCFG} = lists:foldl(fun(IN, {InnerAccAns0, InnerAccParent0, InnerAccVCFG0}) ->
                                                                                                                ValIN = array:get(IN, ValsArr),
                                                                                                                if ValIN =< V ->
                                                                                                                    {ParentAfterPathCompressionN, RootIN} = find(InnerAccParent0, IN),
                                                                                                                    if RootIU /= RootIN ->
                                                                                                                        CountIU = maps:get(RootIU, InnerAccVCFG0, 0),
                                                                                                                        CountIN = maps:get(RootIN, InnerAccVCFG0, 0),

                                                                                                                        % Add new good paths formed by connecting components
                                                                                                                        % If there are CountIU nodes with value V in RootIU's component
                                                                                                                        % and CountIN nodes with value V in RootIN's component,
                                                                                                                        % they form CountIU * CountIN pairs of nodes.
                                                                                                                        % The problem example output implies that (X,Y) and (Y,X) are counted as distinct paths.
                                                                                                                        UpdatedAns = InnerAccAns0 + (CountIU * CountIN),
                                                                                                                        UpdatedParent = union(ParentAfterPathCompressionN, RootIU, RootIN),

                                                                                                                        % Update ValCountsForGroup for the merged component
                                                                                                                        UpdatedVCFG = maps:remove(RootIN, maps:update_with(RootIU, fun(C) -> C + CountIN end, CountIU + CountIN, InnerAccVCFG0)),
                                                                                                                        {UpdatedAns, UpdatedParent, UpdatedVCFG};
                                                                                                                    true ->
                                                                                                                        {InnerAccAns0, InnerAccParent0, InnerAccVCFG0}
                                                                                                                    end;
                                                                                                                true ->
                                                                                                                    {InnerAccAns0, InnerAccParent0, InnerAccVCFG0}
                                                                                                                end
                                                                                                        end, {AccAns, ParentAfterPathCompression, AccVCFG}, Neighbors),
                                                                                                {InnerAccAns, InnerAccParent, InnerAccVCFG}
                                                                                        end, {CurrentAns, ParentAfterFinds, ValCountsForGroup1}, NodesInCurrentGroup),
                                        {NewAns, NewParentAfterUnions}
                                end, {Ans, Parent}, UniqueValues),
    FinalAns.

find(ParentArr, I) ->
    RootI = array:get(I, ParentArr),
    if RootI == I -> {ParentArr, I};
       true ->
            {NewParentArr, NewRootI} = find(ParentArr, RootI),
            {array:set(I, NewRootI, NewParentArr), NewRootI}
    end.

union(ParentArr, R1, R2) ->
    array:set(R2, R1, ParentArr).

initialize_parent(ParentArr, N) ->
    lists:foldl(fun(I, AccParent) -> array:set(I, I, AccParent) end, ParentArr, lists:seq(0, N - 1)).