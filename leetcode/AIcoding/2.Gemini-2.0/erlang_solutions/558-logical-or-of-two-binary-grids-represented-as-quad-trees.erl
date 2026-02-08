-module(quad_tree_or).
-export([or_quad_tree/2]).

-type quad_tree_node() :: {true, []} | {false, []} | {bool, [quad_tree_node(), quad_tree_node(), quad_tree_node(), quad_tree_node()]}.

or_quad_tree({true, _}, _) -> {true, []};
or_quad_tree(_, {true, _}) -> {true, []};
or_quad_tree({false, _}, {false, _}) -> {false, []};
or_quad_tree({bool, [T1, T2, T3, T4]}, {bool, [U1, U2, U3, U4]}) ->
    V1 = or_quad_tree(T1, U1),
    V2 = or_quad_tree(T2, U2),
    V3 = or_quad_tree(T3, U3),
    V4 = or_quad_tree(T4, U4),
    simplify({bool, [V1, V2, V3, V4]}).

simplify({bool, [{true, _}, {true, _}, {true, _}, {true, _}]}) -> {true, []};
simplify({bool, [{false, _}, {false, _}, {false, _}, {false, _}]}) -> {false, []};
simplify(Node) -> Node.