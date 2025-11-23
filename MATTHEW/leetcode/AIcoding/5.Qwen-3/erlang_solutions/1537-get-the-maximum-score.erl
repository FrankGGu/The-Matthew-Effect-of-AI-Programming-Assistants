-module(solution).
-export([max_score/1]).

max_score(Nums) ->
    max_score(Nums, 0, 0, 0, 0).

max_score([], _, _, _, Acc) ->
    Acc;
max_score([H | T], I, A, B, Acc) ->
    case H of
        _ when I rem 2 == 0 ->
            max_score(T, I + 1, A + H, B, Acc);
        _ ->
            max_score(T, I + 1, A, B + H, Acc)
    end.