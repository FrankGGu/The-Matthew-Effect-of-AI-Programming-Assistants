-module(solution).
-export([postorder/1]).

-spec postorder(Node :: map() | nil) -> list(integer()).
postorder(#{val := Val, children := Children}) ->
    ChildrenLists = lists:map(fun(Child) -> postorder(Child) end, Children),
    AllChildrenTraversal = lists:append(ChildrenLists),
    AllChildrenTraversal ++ [Val];
postorder(nil) ->
    [].