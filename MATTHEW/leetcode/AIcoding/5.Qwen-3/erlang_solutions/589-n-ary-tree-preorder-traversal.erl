-module(n_ary_tree_preorder_traversal).
-export([preorder/1]).

-include_lib("eunit/include/eunit.hrl").

preorder(_) -> [].

preorder(#{} = _root) -> [].

preorder(#node{children = Children} = Root) ->
    [Root#node.val | lists:flatmap(fun(Node) -> preorder(Node) end, Children)].