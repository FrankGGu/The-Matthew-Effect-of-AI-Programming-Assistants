-module(solution).
-export([eventualSafeNodes/1]).

eventualSafeNodes(Graph) ->
    N = length(Graph),
    InitialStates = array:new(N, {default, 0}),

    Indices = lists:seq(0, N - 1),

    {_FinalStates, SafeNodesList} = lists:foldl(
        fun(Node, {CurrentStates, AccSafeNodes}) ->
            case dfs(Node, Graph, CurrentStates) of
                {UpdatedStates, true} ->
                    {UpdatedStates, [Node | AccSafeNodes]};
                {UpdatedStates, false} ->
                    {UpdatedStates, AccSafeNodes}
            end
        end,
        {InitialStates, []},
        Indices
    ),

    lists:sort(SafeNodesList).

dfs(U, Graph, States) ->
    CurrentState = array:get(U, States),

    case CurrentState of
        3 -> {States, true};
        2 -> {States, false};
        1 -> {States, false};
        0 ->
            States1 = array:set(U, 1, States),

            Neighbors = lists:nth(U + 1, Graph),

            {FinalStatesForU, AllNeighborsSafe} = 
                lists:foldl(
                    fun(V, {AccStates, AccSafe}) ->
                        case AccSafe of
                            false -> {AccStates, false};
                            true ->
                                case dfs(V, Graph, AccStates) of
                                    {NewStates, true} -> {NewStates, true};
                                    {NewStates, false} -> {NewStates, false}
                                end
                        end
                    end,
                    {States1, true},
                    Neighbors
                ),

            case AllNeighborsSafe of
                true ->
                    UpdatedStates = array:set(U, 3, FinalStatesForU),
                    {UpdatedStates, true};
                false ->
                    UpdatedStates = array:set(U, 2, FinalStatesForU),
                    {UpdatedStates, false}
            end
    end.