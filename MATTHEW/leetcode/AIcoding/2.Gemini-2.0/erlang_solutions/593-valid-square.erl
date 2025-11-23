-module(valid_square).
-export([valid_square/4]).

valid_square(P1, P2, P3, P4) ->
    Points = [P1, P2, P3, P4],
    Dists = [],
    valid_square_helper(Points, Dists, []).

valid_square_helper([], Dists, Acc) ->
    UniqueDists = lists:usort(Dists),
    case length(UniqueDists) of
        2 ->
            Short = lists:nth(1, UniqueDists),
            Long = lists:nth(2, UniqueDists),
            Short > 0 andalso Long =:= 2 * Short;
        _ ->
            false
    end;

valid_square_helper([H | T], Dists, Acc) ->
    NewDists = lists:map(fun(Other) -> dist_sq(H, Other) end, Acc),
    valid_square_helper(T, Dists ++ NewDists, Acc ++ [H]).

dist_sq([X1, Y1], [X2, Y2]) ->
    (X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2).