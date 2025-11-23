-module(solution).
-export([is_possible/2]).

is_possible(N, Edges) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(U, fun(L) -> [V | L] end, [V], 
                          maps:update_with(V, fun(L) -> [U | L] end, [U], Acc))
                      end, #{}, Edges),
    OddNodes = lists:filter(fun(X) -> 
                               case maps:get(X, Adj, []) of
                                   L -> length(L) rem 2 =/= 0
                               end
                           end, lists:seq(1, N)),
    case length(OddNodes) of
        0 -> true;
        2 -> 
            [U, V] = OddNodes,
            case not lists:member(V, maps:get(U, Adj, [])) of
                true -> true;
                false -> 
                    AllNodes = lists:seq(1, N),
                    Candidates = lists:filter(fun(X) -> 
                                                X =/= U andalso X =/= V andalso 
                                                (length(maps:get(X, Adj, [])) rem 2 =:= 1)
                                             end, AllNodes),
                    length(Candidates) > 0
            end;
        _ -> false
    end.