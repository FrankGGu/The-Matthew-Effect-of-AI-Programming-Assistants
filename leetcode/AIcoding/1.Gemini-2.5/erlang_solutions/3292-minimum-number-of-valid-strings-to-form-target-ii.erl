-module(solution).
-export([min_strings/2]).

min_strings(Target, Words) ->
    N = byte_size(Target),

    DP0 = dict:store(N, 0, dict:new()),

    ResultDP = lists:foldr(
        fun(I, CurrentDP) ->
            MinForI = lists:foldl(
                fun(Word, AccMin) ->
                    WordLen = byte_size(Word),
                    NextIndex = I + WordLen,

                    if
                        NextIndex =< N,
                        binary:part(Target, I, WordLen) == Word ->
                            case dict:find(NextIndex, CurrentDP) of
                                {ok, ValAfterWord} ->
                                    case ValAfterWord of
                                        infinity -> AccMin;
                                        _ -> min(AccMin, 1 + ValAfterWord)
                                    end;
                                _ -> 
                                    AccMin
                            end;
                        true ->
                            AccMin
                    end
                end,
                infinity,
                Words
            ),
            dict:store(I, MinForI, CurrentDP)
        end,
        DP0,
        lists:seq(0, N - 1)
    ),

    case dict:find(0, ResultDP) of
        {ok, Val} when Val == infinity -> -1;
        {ok, Val} -> Val;
        _ -> -1
    end.