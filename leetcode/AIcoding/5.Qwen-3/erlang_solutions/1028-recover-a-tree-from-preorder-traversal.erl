-module(recover_tree_from_preorder_traversal).
-export([recover_from_string/1]).

recover_from_string(S) ->
    {Tree, _} = parse(S, 0),
    Tree.

parse([], _) -> {nil, 0};
parse(S, Depth) ->
    {Num, Rest} = read_number(S),
    {_, Rest2} = read_dashes(Rest, Depth),
    Left = parse(Rest2, Depth + 1),
    Right = parse(Left#tree.right, Depth + 1),
    {#tree{val = Num, left = Left#tree.left, right = Right#tree.right}, Right#tree.rest}.

read_number(S) ->
    read_number(S, []).

read_number([], Acc) -> {list_to_integer(lists:reverse(Acc)), []};
read_number([$- | _] = S, _) -> {0, S};
read_number([C | T], Acc) when C >= $0, C =< $9 ->
    read_number(T, [C | Acc]);
read_number(_, Acc) -> {list_to_integer(lists:reverse(Acc)), []}.

read_dashes(S, Depth) ->
    read_dashes(S, 0, Depth).

read_dashes([], _, _) -> {nil, []};
read_dashes([$- | T], Count, Depth) when Count < Depth ->
    read_dashes(T, Count + 1, Depth);
read_dashes(S, _, _) -> {nil, S}.

-record(tree, {val, left, right, rest}).