-module(solution).
-export([nearestValidPoint/2]).

nearestValidPoint({X, Y}, Points) ->
    nearestValidPoint(Points, {X, Y}, 0, -1, infinity).

nearestValidPoint([], _Target, _Index, _BestIndex, _MinDist) ->
    if
        _BestIndex == -1 -> -1;
        true -> _BestIndex
    end;

nearestValidPoint([{PX, PY} | Rest], {TX, TY}, Index, BestIndex, MinDist) ->
    case PX == TX orelse PY == TY of
        true ->
            Dist = abs(PX - TX) + abs(PY - TY),
            if
                Dist < MinDist ->
                    nearestValidPoint(Rest, {TX, TY}, Index + 1, Index, Dist);
                true ->
                    nearestValidPoint(Rest, {TX, TY}, Index + 1, BestIndex, MinDist)
            end;
        false ->
            nearestValidPoint(Rest, {TX, TY}, Index + 1, BestIndex, MinDist)
    end.