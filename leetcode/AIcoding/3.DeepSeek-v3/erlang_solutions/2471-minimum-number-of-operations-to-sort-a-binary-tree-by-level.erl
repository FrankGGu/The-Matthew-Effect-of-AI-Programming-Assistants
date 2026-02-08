-module(solution).
-export([minimum_operations/1]).

minimum_operations(Root) ->
    case Root of
        null -> 0;
        _ ->
            Queue = queue:in(Root, queue:new()),
            bfs(Queue, 0)
    end.

bfs(Queue, Ops) ->
    case queue:is_empty(Queue) of
        true -> Ops;
        false ->
            {Level, NewQueue} = dequeue_level(Queue, queue:new(), []),
            SortedLevel = lists:sort(Level),
            IndexMap = index_map(Level, 0, #{}),
            Ops1 = Ops + count_swaps(Level, SortedLevel, IndexMap),
            bfs(NewQueue, Ops1)
    end.

dequeue_level(Queue, NewQueue, Level) ->
    case queue:is_empty(Queue) of
        true -> {Level, NewQueue};
        false ->
            {{value, Node}, Q} = queue:out(Queue),
            case Node of
                null -> dequeue_level(Q, NewQueue, Level);
                _ ->
                    Left = case Node of
                        #{left := L} -> L;
                        _ -> null
                    end,
                    Right = case Node of
                        #{right := R} -> R;
                        _ -> null
                    end,
                    Val = case Node of
                        #{val := V} -> V;
                        _ -> 0
                    end,
                    NewQueue1 = queue:in(Left, queue:in(Right, NewQueue)),
                    dequeue_level(Q, NewQueue1, [Val | Level])
            end
    end.

index_map([], _, Map) -> Map;
index_map([H | T], I, Map) ->
    index_map(T, I + 1, maps:put(H, I, Map)).

count_swaps(Level, SortedLevel, IndexMap) ->
    Visited = lists:duplicate(length(Level), false),
    count_swaps(Level, SortedLevel, IndexMap, Visited, 0).

count_swaps([], _, _, _, Count) -> Count;
count_swaps(Level, SortedLevel, IndexMap, Visited, Count) ->
    {Start, Visited1} = find_unvisited(Visited, 0),
    case Start of
        -1 -> Count;
        _ ->
            {CycleSize, Visited2} = traverse_cycle(Start, Level, SortedLevel, IndexMap, Visited1, 0),
            count_swaps(Level, SortedLevel, IndexMap, Visited2, Count + (CycleSize - 1))
    end.

find_unvisited(Visited, I) ->
    case I >= length(Visited) of
        true -> {-1, Visited};
        false ->
            case lists:nth(I + 1, Visited) of
                false -> {I, list_to_tuple(setelement(I + 1, list_to_tuple(Visited), true))};
                true -> find_unvisited(Visited, I + 1)
            end
    end.

traverse_cycle(Current, Level, SortedLevel, IndexMap, Visited, CycleSize) ->
    case lists:nth(Current + 1, Visited) of
        true -> {CycleSize, Visited};
        false ->
            Val = lists:nth(Current + 1, Level),
            DesiredVal = lists:nth(Current + 1, SortedLevel),
            NextPos = maps:get(DesiredVal, IndexMap),
            Visited1 = list_to_tuple(setelement(Current + 1, list_to_tuple(Visited), true)),
            traverse_cycle(NextPos, Level, SortedLevel, IndexMap, Visited1, CycleSize + 1)
    end.