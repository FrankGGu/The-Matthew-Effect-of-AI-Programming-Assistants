-module(solution).
-export([first_painted/2]).

first_painted(N, A) ->
    Rows = lists:foldl(fun({X, Y}, Acc) -> 
        lists:update_at(X + 1, fun(P) -> P + 1 end, Acc)
    end, lists:duplicate(N, 0), A),
    Columns = lists:foldl(fun({X, Y}, Acc) -> 
        lists:update_at(Y + 1, fun(P) -> P + 1 end, Acc)
    end, lists:duplicate(N, 0), A),
    case lists:prefix(Rows, lists:duplicate(N, N)) of
        true -> {ok, lists:find_index(fun(X) -> X == N end, Rows)};
        false -> case lists:prefix(Columns, lists:duplicate(N, N)) of
            true -> {ok, lists:find_index(fun(X) -> X == N end, Columns)};
            false -> -1
        end
    end.

lists:update_at(Index, Fun, List) ->
    case lists:nth(Index, List) of
        undefined -> List;
        _ -> lists:replace(Index, Fun(lists:nth(Index, List)), List)
    end.

lists:find_index(Pred, List) ->
    lists:foldl(fun(X, {Idx, Acc}) ->
        case Pred(X) of
            true -> {Idx, true};
            false -> {Idx + 1, Acc}
        end
    end, {0, false}, List).