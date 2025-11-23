-module(count_teams).
-export([numTeams/1]).

numTeams(Rating) ->
  Len = length(Rating),
  numTeamsHelper(Rating, 0, Len, 0).

numTeamsHelper(_Rating, I, Len, Count) when I >= Len - 2 ->
  Count;
numTeamsHelper(Rating, I, Len, Count) ->
  Count1 = lists:foldl(fun(J, Acc) ->
                         case Rating J > Rating I of
                           true ->
                             lists:foldl(fun(K, Acc2) ->
                                            case Rating K > Rating J of
                                              true ->
                                                Acc2 + 1;
                                              false ->
                                                Acc2
                                            end
                                          end, Acc, lists:seq(J+1, Len-1));
                           false ->
                             Acc
                         end
                       end, 0, lists:seq(I+1, Len-2)),
  Count2 = lists:foldl(fun(J, Acc) ->
                         case Rating J < Rating I of
                           true ->
                             lists:foldl(fun(K, Acc2) ->
                                            case Rating K < Rating J of
                                              true ->
                                                Acc2 + 1;
                                              false ->
                                                Acc2
                                            end
                                          end, Acc, lists:seq(J+1, Len-1));
                           false ->
                             Acc
                         end
                       end, 0, lists:seq(I+1, Len-2)),
  numTeamsHelper(Rating, I+1, Len, Count + Count1 + Count2).