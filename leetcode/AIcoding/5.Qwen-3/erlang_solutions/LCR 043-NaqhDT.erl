-module(leetcode_714).
-export([insert/2, get_root/1]).

-include_lib("eunit/include/eunit.hrl").

-record(tn, {val, left, right}).

insert(Val, none) ->
    #tn{val = Val};
insert(Val, Tree) ->
    insert_val(Val, Tree).

insert_val(Val, Tree) ->
    Queue = [Tree],
    insert_val(Val, Queue).

insert_val(_Val, []) ->
    none;
insert_val(Val, [Node | Rest]) ->
    case Node#tn.left of
        none ->
            Node#tn{left = #tn{val = Val}};
        _ ->
            case Node#tn.right of
                none ->
                    Node#tn{right = #tn{val = Val}};
                _ ->
                    insert_val(Val, Rest ++ [Node#tn.left, Node#tn.right])
            end
    end.

get_root(Tree) ->
    Tree.