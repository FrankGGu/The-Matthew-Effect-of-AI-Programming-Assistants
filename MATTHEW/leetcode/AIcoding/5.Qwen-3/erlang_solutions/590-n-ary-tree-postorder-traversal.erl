-module(n_ary_tree_postorder_traversal).
-export([postorder/1]).

-include_lib("eunit/include/eunit.hrl").

-type node() :: {integer(), list(node())}.

postorder(undefined) -> [];
postorder({Val, Children}) ->
    lists:foldl(fun(Child, Acc) -> postorder(Child) ++ Acc end, [Val], Children).