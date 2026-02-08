-module(solution).
-export([shortestImpossibleSequence/2]).

shortestImpossibleSequence(Rolls, K) ->
    {_CurrentNum, NumSequences} = lists:foldl(
        fun(Roll, {CurrentNum, AccNumSequences}) ->
            if
                Roll == CurrentNum ->
                    NewCurrentNum = CurrentNum + 1,
                    if
                        NewCurrentNum > K ->
                            {1, AccNumSequences + 1};
                        true ->
                            {NewCurrentNum, AccNumSequences}
                    end;
                true ->
                    {CurrentNum, AccNumSequences}
            end
        end,
        {1, 0},
        Rolls
    ),
    NumSequences + 1.