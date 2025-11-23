-spec level_order(Root :: #node{} | null) -> [[integer()]].
level_order(null) -> [];
level_order(Root) ->
    Queue = queue:in(Root, queue:new()),
    level_order(queue:new(), Queue, [], []).

level_order(_CurrentQueue, NextQueue, [], Acc) ->
    case queue:is_empty(NextQueue) of
        true -> lists:reverse(Acc);
        false -> level_order(NextQueue, queue:new(), [], Acc)
    end;
level_order(CurrentQueue, NextQueue, CurrentLevel, Acc) ->
    {{value, Node}, RemainingQueue} = queue:out(CurrentQueue),
    NewCurrentLevel = [Node#node.val | CurrentLevel],
    NewNextQueue = lists:foldl(fun(Child, Q) -> queue:in(Child, Q) end, NextQueue, Node#node.children),
    level_order(RemainingQueue, NewNextQueue, NewCurrentLevel, Acc).