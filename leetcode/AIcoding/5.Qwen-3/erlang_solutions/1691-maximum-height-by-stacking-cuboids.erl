-module(solution).
-export([max_height/1]).

max_height(Cuboids) ->
    Sorted = lists:sort(fun(A, B) -> 
        case A of
            [X1, Y1, Z1] ->
                case B of
                    [X2, Y2, Z2] ->
                        if X1 < X2 -> true;
                           X1 == X2 -> 
                               if Y1 < Y2 -> true;
                                  Y1 == Y2 -> Z1 < Z2;
                                  true -> false
                               end;
                           true -> false
                        end
                end
        end
    end, Cuboids),
    dp(Sorted, []).

dp([], Acc) ->
    lists:max(Acc);
dp([H | T], Acc) ->
    {Max, _} = lists:foldl(fun({X, Y, Z}, {Current, MaxSoFar}) ->
        case (X >= Current) and (Y >= Current) and (Z >= Current) of
            true ->
                {Z + Current, max(MaxSoFar, Z + Current)};
            false ->
                {Current, MaxSoFar}
        end
    end, {0, 0}, H),
    dp(T, [Max | Acc]).