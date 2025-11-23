-module(solution).
-export([isEscapePossible/3]).

-define(GRID_SIZE, 1000000).
-define(MAX_BLOCKED_COUNT, 200).
-define(MAX_VISIT_LIMIT, ?MAX_BLOCKED_COUNT * ?MAX_BLOCKED_COUNT).

isEscapePossible(BlockedList, Source, Target) ->
    BlockedSet = list_to_gb_set(BlockedList),
    can_reach(Source, Target, BlockedSet, ?MAX_VISIT_LIMIT) andalso
    can_reach(Target, Source, BlockedSet, ?MAX_VISIT_LIMIT).

can_reach(Start, Target, BlockedSet, MaxVisitLimit) ->
    Queue = queue:in(Start, queue:new()),
    Visited = gb_sets:add(Start, gb_sets:new()),
    bfs(Queue, Visited, Target, BlockedSet, MaxVisitLimit, 1).

bfs(Queue, Visited, Target, BlockedSet, MaxVisitLimit, VisitedCount) ->
    case queue:out(Queue) of
        {{value, Current}, RestQueue} ->
            if
                Current == Target ->
                    true;
                VisitedCount >= MaxVisitLimit ->
                    true;
                true ->
                    Neighbors = get_neighbors(Current),
                    {UpdatedQueue, UpdatedVisited, UpdatedVisitedCount} =
                        lists:foldl(fun(Neighbor, {Q, V, VC}) ->
                                if
                                    not gb_sets:is_element(Neighbor, BlockedSet) andalso
                                    not gb_sets:is_element(Neighbor, V) ->
                                        {queue:in(Neighbor, Q), gb_sets:add(Neighbor, V), VC + 1};
                                    true ->
                                        {Q, V, VC}
                                end
                            end, {RestQueue, Visited, VisitedCount}, Neighbors),
                    bfs(UpdatedQueue, UpdatedVisited, Target, BlockedSet, MaxVisitLimit, UpdatedVisitedCount)
            end;
        empty ->
            false
    end.

get_neighbors({R, C}) ->
    Directions = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],
    lists:filter(fun({NR, NC}) ->
        NR >= 0 andalso NR < ?GRID_SIZE andalso
        NC >= 0 andalso NC < ?GRID_SIZE
    end,
    lists:map(fun({DR, DC}) -> {R + DR, C + DC} end, Directions)).

list_to_gb_set(List) ->
    lists:foldl(fun(Element, Set) -> gb_sets:add(Element, Set) end, gb_sets:new(), List).