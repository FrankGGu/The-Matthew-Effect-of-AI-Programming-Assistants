-module(solution).
-export([min_skips/3]).

min_skips(Dist, Speed, HoursBefore) ->
    TotalDist = lists:sum(Dist),
    TotalTime = TotalDist / Speed,
    if TotalTime =< HoursBefore -> 0;
       true -> 
           N = length(Dist),
           DP = lists:duplicate(N + 1, lists:duplicate(N + 1, 1.0e20)),
           DP1 = setelement(1, DP, setelement(1, element(1, DP), 0.0)),
           {Res, _} = lists:foldl(fun(D, {Dp, I}) ->
               NewDp = lists:foldl(fun(J, Acc) ->
                   PrevNoSkip = element(J, element(I, Dp)),
                   TimeNoSkip = ceil(PrevNoSkip + D / Speed - 1.0e-9) * Speed,
                   PrevSkip = element(J + 1, element(I, Dp)),
                   TimeSkip = PrevSkip + D,
                   NewVal = min(TimeNoSkip, TimeSkip),
                   setelement(J + 1, element(I + 1, Acc), NewVal)
               end, Dp, lists:seq(0, I - 1)),
               {NewDp, I + 1}
           end, {DP1, 1}, Dist),
           case lists:foldl(fun(K, MinK) ->
               Time = element(K + 1, element(N + 1, Res)),
               if Time / Speed =< HoursBefore -> min(MinK, K);
                  true -> MinK
               end
           end, N, lists:seq(0, N)) of
               NK when NK =< N -> NK;
               _ -> -1
           end
    end.