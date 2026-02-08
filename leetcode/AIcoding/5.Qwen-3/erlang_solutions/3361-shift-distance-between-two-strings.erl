-module(solution).
-export([shift_distance/2]).

shift_distance(A, B) ->
    shift_distance(A, B, 0, 0, 0).

shift_distance([], [], _, _, Acc) ->
    Acc;
shift_distance(_, [], _, _, Acc) ->
    Acc;
shift_distance([], _, _, _, Acc) ->
    Acc;
shift_distance([H|T1], [H|T2], I, J, Acc) ->
    shift_distance(T1, T2, I+1, J+1, Acc);
shift_distance([H|T1], [M|T2], I, J, Acc) ->
    case lists:member(H, T2) of
        true ->
            Index = lists:foldl(fun(X, Acc2) -> if X == H -> Acc2 + 1; true -> Acc2 + 1 end end, 0, T2),
            shift_distance(T1, T2, I+1, J+1, Acc + Index);
        false ->
            shift_distance(T1, T2, I+1, J+1, Acc)
    end.