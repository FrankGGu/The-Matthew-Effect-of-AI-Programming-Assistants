-module(best_team).
-export([best_team_score/2]).

best_team_score(Scores, Ages) ->
  N = length(Scores),
  Players = lists:zip(Scores, Ages),
  SortedPlayers = lists:sort(fun({S1, A1}, {S2, A2}) ->
                               if A1 < A2 ->
                                 true;
                               if A1 == A2 ->
                                 S1 < S2;
                               if A1 > A2 ->
                                 false
                               end
                             end, Players),
  best_team_score_helper(SortedPlayers, N).

best_team_score_helper(Players, N) ->
  DP = array:new(N, {fixed, 0}),

  lists:foldl(fun({Score, _Age}, I, Acc) ->
                  MaxScore = lists:foldl(fun({Score2, _Age2}, J, Max) ->
                                             if Score >= Score2 ->
                                               max(Max, array:get(J, DP))
                                             else
                                               Max
                                             end
                                         end, 0, lists:seq(1, I-1)),

                  NewScore = MaxScore + Score,
                  array:set(I, NewScore, DP),
                  max(Acc, NewScore)
              end, 0, lists:zip(Players, lists:seq(1, N))).