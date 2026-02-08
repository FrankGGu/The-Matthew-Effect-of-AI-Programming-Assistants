-module(count_paths).
-export([count_paths/1]).

count_paths(Parent) ->
    N = length(Parent) + 1,
    Adj = lists:foldl(fun(I, Acc) ->
                                     case I of
                                         -1 -> Acc;
                                         P ->
                                             case lists:keyfind(P + 1, 1, Acc) of
                                                 false ->
                                                     lists:keyreplace(P + 1, 1, Acc, {P + 1, [I + 1]});
                                                 {_, Neighbors} ->
                                                     lists:keyreplace(P + 1, 1, Acc, {P + 1, [I + 1 | Neighbors]})
                                             end
                                     end
                             end, lists:seq(1, N, []), lists:seq(1, N - 1)),
    dfs(1, 0, Adj, #{0 => 1}, 0).

dfs(Node, Mask, Adj, Memo, Acc) ->
    NewMemo = maps:update_with(Mask, fun(X) -> X + 1 end, 1, Memo),
    Acc1 = Acc + maps:get(Mask, Memo, 0) - maps:get(Mask, NewMemo, 0),
    Acc2 = lists:foldl(fun(I, AccInner) ->
                                AccInner + maps:get(Mask bxor (1 bsl (I - 1)), Memo, 0) - maps:get(Mask bxor (1 bsl (I - 1)), NewMemo, 0)
                        end, 0, lists:seq(1, 26)),

    case lists:keyfind(Node, 1, Adj) of
        false -> Acc1 + Acc2;
        {_, Neighbors} ->
            lists:foldl(fun(Neighbor, AccNext) ->
                                 dfs(Neighbor, Mask bxor (1 bsl (Neighbor - 1)), Adj, NewMemo, AccNext)
                         end, Acc1 + Acc2, Neighbors)
    end.