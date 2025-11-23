-module(solution).
-export([preorder/1]).

-spec preorder(Node :: map() | nil) -> [integer()].
preorder(nil) -> [];
preorder(#{val := Val, children := Children}) ->
    [Val | lists:flatmap(fun(Child) -> preorder(Child) end, Children)].