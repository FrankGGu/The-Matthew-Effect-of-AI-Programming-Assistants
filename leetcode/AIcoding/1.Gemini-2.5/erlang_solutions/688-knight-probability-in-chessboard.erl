-module(solution).
-export([knightProbability/4]).

knightProbability(N, K, R, C) ->
    Moves = [{1,2}, {1,-2}, {-1,2}, {-1,-2}, {2,1}, {2,-1}, {-2,1}, {-2,-1}],

    DP_prev = #{ {R, C} => 1.0 },

    ResultDP = lists:foldl(fun(_Idx, AccDP) ->
        DP_curr = maps:new(),

        maps:fold(fun({CurR, CurC}, CurProb, InnerAccDP) ->
            lists:foldl(fun({DR, DC}, MostInnerAccDP) ->
                NextR = CurR + DR,
                NextC = CurC + DC,

                if
                    NextR >= 0 andalso NextR < N andalso NextC >= 0 andalso NextC < N ->
                        ProbToAdd = CurProb / 8.0,
                        maps:update_with({NextR, NextC}, fun(OldVal) -> OldVal + ProbToAdd end, ProbToAdd, MostInnerAccDP);
                    true ->
                        MostInnerAccDP
                end
            end, InnerAccDP, Moves)
        end, DP_curr, AccDP)
    end, DP_prev, lists:seq(1, K)),

    lists:sum(maps:values(ResultDP)).