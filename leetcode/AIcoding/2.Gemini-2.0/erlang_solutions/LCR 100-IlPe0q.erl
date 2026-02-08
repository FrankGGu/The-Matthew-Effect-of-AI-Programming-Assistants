-module(triangle_min_path_sum).
-export([minimumTotal/1]).

minimumTotal(Triangle) ->
    minimumTotal(Triangle, []).

minimumTotal([], Acc) ->
    lists:min(Acc);
minimumTotal([Row | Rest], Acc) ->
    case Acc of
        [] ->
            minimumTotal(Rest, Row);
        _ ->
            NewAcc = lists:zipwith(fun(X, Y, Z) -> X + min(Y, Z) end, Row, [hd(Acc) | Acc], Acc ++ [hd(Acc)]),
            minimumTotal(Rest, NewAcc)
    end.