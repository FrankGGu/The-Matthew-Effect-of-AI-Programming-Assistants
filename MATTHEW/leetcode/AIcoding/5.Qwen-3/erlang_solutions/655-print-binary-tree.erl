-module(print_binary_tree).
-export([print_tree/1]).

-type tree() :: 'null' | {tree(), integer(), tree()}.

-spec print_tree(tree()) -> [[string()]].
print_tree(null) ->
    [];
print_tree({Left, Val, Right}) ->
    Height = height({Left, Val, Right}),
    Rows = lists:duplicate(Height, []),
    print_tree({Left, Val, Right}, 0, Rows).

print_tree(null, _, Acc) ->
    Acc;
print_tree({Left, Val, Right}, Level, Acc) ->
    Row = lists:nth(Level + 1, Acc),
    Index = 2^(Height - Level - 1) - 1,
    NewRow = lists:sublist(Row, Index) ++ [integer_to_list(Val)] ++ lists:sublist(Row, Index + 1, length(Row) - Index - 1),
    UpdatedAcc = lists:substitute(Level + 1, NewRow, Acc),
    print_tree(Left, Level + 1, UpdatedAcc),
    print_tree(Right, Level + 1, UpdatedAcc).

height(null) ->
    0;
height({Left, _, Right}) ->
    1 + max(height(Left), height(Right)).