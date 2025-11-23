-module(solution).
-export([max_score/1]).

max_score(Positions) ->
    max_score(Positions, 0, 0, 0).

max_score([], _, _, Acc) ->
    Acc;
max_score([Pos | Rest], Index, Last, Acc) ->
    case Pos of
        _ when Index - Last >= 2 ->
            max_score(Rest, Index + 1, Index, Acc + 1);
        _ ->
            max_score(Rest, Index + 1, Last, Acc)
    end.