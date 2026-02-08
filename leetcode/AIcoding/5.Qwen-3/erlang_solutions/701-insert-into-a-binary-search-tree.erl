-module(insert_into_bst).
-export([insert_into_bst/2]).

-record(bst, {val, left, right}).

insert_into_bst(nil, Val) ->
    #bst{val = Val};
insert_into_bst(#bst{val = Val, left = Left, right = Right}, InsertVal) when InsertVal < Val ->
    #bst{val = Val, left = insert_into_bst(Left, InsertVal), right = Right};
insert_into_bst(#bst{val = Val, left = Left, right = Right}, InsertVal) ->
    #bst{val = Val, left = Left, right = insert_into_bst(Right, InsertVal)}.