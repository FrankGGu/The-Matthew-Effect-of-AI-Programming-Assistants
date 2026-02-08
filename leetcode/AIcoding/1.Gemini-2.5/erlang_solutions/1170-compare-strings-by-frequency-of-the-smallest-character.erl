-module(solution).
-export([numSmallerByFrequency/2]).

f(S) ->
    MinChar = lists:min(S),
    lists:foldl(fun(C, Acc) ->
                    if C == MinChar -> Acc + 1;
                       true -> Acc
                    end
                end, 0, S).

numSmallerByFrequency(Queries, Words) ->
    WordFrequencies = lists:map(fun(W) -> f(W) end, Words),
    QueryFrequencies = lists:map(fun(Q) -> f(Q) end, Queries),

    lists:map(fun(QF) ->
                  lists:foldl(fun(WF, Acc) ->
                                  if QF < WF -> Acc + 1;
                                     true -> Acc
                                  end
                              end, 0, WordFrequencies)
              end, QueryFrequencies).