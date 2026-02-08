-module(solution).
-export([intersectionSizeTwo/1]).

intersectionSizeTwo(Intervals) ->
    SortedIntervals = lists:sort(fun([S1, E1], [S2, E2]) ->
                                     if E1 =:= E2 -> S1 > S2;
                                        true -> E1 < E2
                                     end
                                 end, Intervals),

    {Ans, _, _} = lists:foldl(fun([Start, End], {AccAns, P1, P2}) ->
                                  if P2 < Start ->
                                      {AccAns + 2, End, End - 1};
                                     P1 < Start ->
                                      {AccAns + 1, End, P2};
                                     true ->
                                      {AccAns, P1, P2}
                                  end
                              end, {0, -1, -1}, SortedIntervals),
    Ans.