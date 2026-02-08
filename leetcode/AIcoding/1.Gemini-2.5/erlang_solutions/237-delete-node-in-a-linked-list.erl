-module(solution).
-export([delete_node/1]).

delete_node(Node) ->
    NextNode = list_node:get_next(Node),
    NextVal = list_node:get_val(NextNode),
    NextNext = list_node:get_next(NextNode),

    list_node:set_val(Node, NextVal),
    list_node:set_next(Node, NextNext),
    ok.