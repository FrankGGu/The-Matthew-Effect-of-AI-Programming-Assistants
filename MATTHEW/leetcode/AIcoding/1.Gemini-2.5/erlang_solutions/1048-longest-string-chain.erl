-module(solution).
-export([longest_string_chain/1]).

longest_string_chain(Words) ->
    SortedWords = lists:sort(fun(A, B) -> length(A) < length(B) end, Words),

    {MaxOverallChain, _ChainLengthsMap} = maps:foldl(
        fun(Word, Acc) ->
            MaxOverallChainAcc = element(1, Acc),
            ChainLengthsMap = element(2, Acc),

            CurrentWordChainLength = 1,

            PredecessorChainLengths = [
                maps:get(Predecessor, ChainLengthsMap, 0) + 1
                || I <- lists:seq(1, length(Word)),
                   Predecessor = lists:sublist(Word, 1, I-1) ++ lists:sublist(Word, I+1, length(Word)-I)
            ],

            MaxChainForWord = lists:foldl(fun(Len, Max) -> max(Len, Max) end, CurrentWordChainLength, PredecessorChainLengths),

            NewChainLengthsMap = maps:put(Word, MaxChainForWord, ChainLengthsMap),
            NewMaxOverallChain = max(MaxOverallChainAcc, MaxChainForWord),

            {NewMaxOverallChain, NewChainLengthsMap}
        end, {0, maps:new()}, SortedWords),

    MaxOverallChain.