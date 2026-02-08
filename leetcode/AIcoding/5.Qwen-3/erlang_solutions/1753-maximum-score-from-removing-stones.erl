-module(max_score_from_removing_stones).
-export([maxScore/3]).

maxScore(A, B, C) ->
    lists:foldl(fun(_I, Acc) ->
                        [X, Y, Z] = lists:sort(Acc),
                        if
                            X == 0 -> Acc;
                            true ->
                                case {Y - X, Z - X} of
                                    {0, 0} -> [0, 0, 0];
                                    {0, _} -> [0, 0, Z - X];
                                    {_, 0} -> [0, 0, Y - X];
                                    {_, _} -> [0, Y - X, Z - X]
                                end
                        end
                    end, [A, B, C], lists:seq(1, 1000)).