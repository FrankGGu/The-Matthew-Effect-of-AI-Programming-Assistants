-module(solution).
-export([findOrder/2]).

findOrder(NumCourses, Prerequisites) ->
    Graph = maps:from_list([{I, []} || I <- lists:seq(0, NumCourses-1)]),
    InDegree = maps:from_list([{I, 0} || I <- lists:seq(0, NumCourses-1)]),

    {FinalGraph, FinalInDegree} = lists:foldl(
        fun([A, B], {G, ID}) ->
            NewG = maps:update_with(B, fun(L) -> [A | L] end, [], G),
            NewID = maps:update_with(A, fun(V) -> V + 1 end, 0, ID),
            {NewG, NewID}
        end,
        {Graph, InDegree},
        Prerequisites
    ),

    InitialQ = [C || C <- lists:seq(0, NumCourses-1), maps:get(C, FinalInDegree) == 0],

    ResultAcc = toposort(InitialQ, [], FinalInDegree, FinalGraph),

    FinalResult = lists:reverse(ResultAcc),
    if
        length(FinalResult) == NumCourses ->
            FinalResult;
        true ->
            []
    end.

toposort(Q, ResultAcc, InDegreeMap, GraphMap) ->
    case Q of
        [] ->
            ResultAcc;
        [U | RestQ] ->
            NewResultAcc = [U | ResultAcc],
            Neighbors = maps:get(U, GraphMap),

            {UpdatedInDegreeMap, NewQAdditions} = lists:foldl(
                fun(V, {IDAcc, QAddAcc}) ->
                    NewVInDegree = maps:get(V, IDAcc) - 1,
                    UpdatedIDAcc = maps:put(V, NewVInDegree, IDAcc),
                    if
                        NewVInDegree == 0 ->
                            {UpdatedIDAcc, [V | QAddAcc]};
                        true ->
                            {UpdatedIDAcc, QAddAcc}
                    end
                end,
                {InDegreeMap, []},
                Neighbors
            ),

            NextQ = NewQAdditions ++ RestQ,
            toposort(NextQ, NewResultAcc, UpdatedInDegreeMap, GraphMap)
    end.