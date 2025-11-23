-module(solution).
-export([checkIfPrerequisite/3]).

-include_lib("stdlib/include/array.hrl").

checkIfPrerequisite(NumCourses, Prerequisites, Queries) ->
    InitialReachable = initialize_reachable_array(NumCourses, Prerequisites),
    FinalReachable = floyd_warshall_array(NumCourses, InitialReachable),
    process_queries_array(Queries, FinalReachable).

initialize_reachable_array(NumCourses, Prerequisites) ->
    Rows = [
        array:from_list([ if I == J then true else false end || J <- lists:seq(0, NumCourses - 1) ])
        || I <- lists:seq(0, NumCourses - 1)
    ],
    Matrix = array:from_list(Rows),

    lists:foldl(
        fun([U, V], AccMatrix) ->
            CurrentRow = array:get(U, AccMatrix),
            UpdatedRow = array:set(V, true, CurrentRow),
            array:set(U, UpdatedRow, AccMatrix)
        end,
        Matrix,
        Prerequisites
    ).

floyd_warshall_array(NumCourses, InitialReachable) ->
    lists:foldl(
        fun(K, CurrentReachable) ->
            lists:foldl(
                fun(I, AccReachableForK) ->
                    RI_K_prev = array:get(K, array:get(I, CurrentReachable)),

                    UpdatedRowI = lists:foldl(
                        fun(J, InnerRowI) ->
                            RIJ_prev = array:get(J, array:get(I, CurrentReachable)),
                            RKJ_prev = array:get(J, array:get(K, CurrentReachable)),

                            NewRIJ = RIJ_prev or (RI_K_prev and RKJ_prev),

                            array:set(J, NewRIJ, InnerRowI)
                        end,
                        array:get(I, CurrentReachable),
                        lists:seq(0, NumCourses - 1)
                    ),
                    array:set(I, UpdatedRowI, AccReachableForK)
                end,
                CurrentReachable,
                lists:seq(0, NumCourses - 1)
            )
        end,
        InitialReachable,
        lists:seq(0, NumCourses - 1)
    ).

process_queries_array(Queries, FinalReachable) ->
    [ array:get(V, array:get(U, FinalReachable)) || [U, V] <- Queries ].