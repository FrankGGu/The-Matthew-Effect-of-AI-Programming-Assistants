-module(solution).
-export([minJumps/1]).

minJumps(Arr) ->
    N = length(Arr),
    if
        N =:= 1 -> 0;
        true ->
            Array = array:from_list(Arr),
            ValueToIndices = build_value_to_indices(Array, N),

            Q = queue:in({0, 0}, queue:new()),
            Visited = maps:put(0, true, #{}),

            bfs(Q, Visited, ValueToIndices, Array, N)
    end.

build_value_to_indices(Array, N) ->
    build_value_to_indices(0, N, Array, #{}).

build_value_to_indices(Idx, N, Array, AccMap) when Idx < N ->
    Value = array:get(Idx, Array),
    CurrentIndices = maps:get(Value, AccMap, []),
    NewAccMap = maps:put(Value, [Idx | CurrentIndices], AccMap),
    build_value_to_indices(Idx + 1, N, Array, NewAccMap);
build_value_to_indices(_Idx, _N, _Array, AccMap) ->
    AccMap.

bfs(Q, Visited, ValueToIndices, Array, N) ->
    {{value, {CurrentIdx, Steps}}, NewQ} = queue:out(Q),

    if
        CurrentIdx =:= N - 1 ->
            Steps;
        true ->
            Value = array:get(CurrentIdx, Array),

            Neighbors = [],

            Neighbors1 = 
                if 
                    CurrentIdx + 1 < N ->
                        [CurrentIdx + 1 | Neighbors];
                    true ->
                        Neighbors
                end,

            Neighbors2 = 
                if 
                    CurrentIdx - 1 >= 0 ->
                        [CurrentIdx - 1 | Neighbors1];
                    true ->
                        Neighbors1
                end,

            SameValueIndices = maps:get(Value, ValueToIndices, []),
            Neighbors3 = SameValueIndices ++ Neighbors2,

            {UpdatedQ, UpdatedVisited} = lists:foldl(fun(NextIdx, {QAcc, VisitedAcc}) ->
                                                        if
                                                            not maps:is_key(NextIdx, VisitedAcc) ->
                                                                {queue:in({NextIdx, Steps + 1}, QAcc), maps:put(NextIdx, true, VisitedAcc)};
                                                            true ->
                                                                {QAcc, VisitedAcc}
                                                        end
                                                    end, {NewQ, Visited}, Neighbors3),

            NewValueToIndices = maps:remove(Value, ValueToIndices),

            bfs(UpdatedQ, UpdatedVisited, NewValueToIndices, Array, N)
    end.