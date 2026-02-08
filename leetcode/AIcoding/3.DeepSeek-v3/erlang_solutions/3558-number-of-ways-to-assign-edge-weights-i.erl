-module(solution).
-export([number_of_ways/2]).

number_of_ways(N, Edges) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
                      end, #{}, Edges),
    Count = count_ways(1, -1, Adj, N),
    Count.

count_ways(Node, Parent, Adj, N) ->
    Children = case maps:get(Node, Adj, []) of
                   L -> [V || V <- L, V =/= Parent]
               end,
    case Children of
        [] -> 1;
        _ ->
            ChildCounts = lists:map(fun(Child) -> count_ways(Child, Node, Adj, N) end, Children),
            lists:foldl(fun(C, Acc) -> (Acc * C) rem 1000000007 end, 1, ChildCounts)
    end.