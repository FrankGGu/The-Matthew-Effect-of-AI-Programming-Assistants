-module(solution).
-export([closest_number_to_zero/1]).

closest_number_to_zero([H|T]) ->
    lists:foldl(fun(N, CurrentClosest) ->
        AbsN = abs(N),
        AbsCurrentClosest = abs(CurrentClosest),
        if
            AbsN < AbsCurrentClosest -> N;
            AbsN == AbsCurrentClosest ->
                if
                    N > CurrentClosest -> N;
                    true -> CurrentClosest
                end;
            true -> CurrentClosest
        end
    end, H, T).