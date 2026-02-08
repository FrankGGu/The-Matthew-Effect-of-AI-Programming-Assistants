-module(solution).
-export([longestCycle/1]).

longestCycle(EdgesList) ->
    N = length(EdgesList),
    Edges = array:from_list(EdgesList),

    States = array:new(N, {default, 0}),
    PathDistances = array:new(N, {default, -1}),

    AccMaxCycleLen = -1,

    {_FinalStates, _FinalPathDistances, FinalMaxCycleLen} = 
        lists:foldl(fun(I, {CurrentStates, CurrentPathDistances, CurrentMaxCycleLen}) ->
            StateI = array:get(I, CurrentStates),
            case StateI of
                0 -> 
                    dfs_loop_helper(I, 0, Edges, CurrentStates, CurrentPathDistances, CurrentMaxCycleLen, [])
                _ -> 
                    {CurrentStates, CurrentPathDistances, CurrentMaxCycleLen}
            end
        end, {States, PathDistances, AccMaxCycleLen}, lists:seq(0, N - 1)),

    FinalMaxCycleLen.

dfs_loop_helper(Node, Dist, Edges, States, PathDistances, AccMaxCycleLen, VisitedInCurrentPath) ->
    case Node of
        -1 -> 
            finalize_path(VisitedInCurrentPath, States, PathDistances, AccMaxCycleLen);
        _ ->
            StateOfNode = array:get(Node, States),
            case StateOfNode of
                1 -> 
                    CycleLen = Dist - array:get(Node, PathDistances),
                    NewAccMaxCycleLen = max(AccMaxCycleLen, CycleLen),
                    finalize_path(VisitedInCurrentPath, States, PathDistances, NewAccMaxCycleLen);
                2 -> 
                    finalize_path(VisitedInCurrentPath, States, PathDistances, AccMaxCycleLen);
                0 -> 
                    NewStates = array:set(Node, 1, States),
                    NewPathDistances = array:set(Node, Dist, PathDistances),
                    NextNodeVal = array:get(Node, Edges),

                    dfs_loop_helper(NextNodeVal, Dist + 1, Edges, NewStates, NewPathDistances, AccMaxCycleLen, [Node | VisitedInCurrentPath])
            end
    end.

finalize_path(VisitedNodes, States, PathDistances, AccMaxCycleLen) ->
    FinalStates = lists:foldl(fun(Node, AccStates) ->
        array:set(Node, 2, AccStates)
    end, States, VisitedNodes),
    {FinalStates, PathDistances, AccMaxCycleLen}.