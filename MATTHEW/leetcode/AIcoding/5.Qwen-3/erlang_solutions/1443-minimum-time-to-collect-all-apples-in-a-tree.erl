-module(solution).
-export([min_time_to_collect_all_apples/1]).

min_time_to_collect_all_apples(Edges) ->
    Tree = build_tree(Edges),
    collect_apples(Tree, 0, 0).

build_tree(Edges) ->
    Map = maps:new(),
    lists:foldl(fun({A, B}, Acc) ->
        Acc1 = maps:update_with(A, fun(V) -> [B | V] end, [B], Acc),
        maps:update_with(B, fun(V) -> [A | V] end, [A], Acc1)
    end, Map, Edges).

collect_apples(_, _, 0) -> 0;
collect_apples(Tree, Node, Apple) ->
    Children = maps:get(Node, Tree),
    Total = 0,
    lists:foreach(fun(Child) ->
        if
            Child /= 0 ->
                SubTotal = collect_apples(Tree, Child, Apple),
                if
                    SubTotal > 0 -> Total = Total + SubTotal + 2;
                    true -> ok
                end;
            true -> ok
        end
    end, Children),
    Total.