-module(solution).
-export([getAverages/2]).

getAverages(Nums, K) ->
    N = length(Nums),
    WindowSize = 2 * K + 1,

    {_, PrefixSumsReversed} = lists:foldl(fun(Num, {CurrentSum, Acc}) ->
                                              NewSum = CurrentSum + Num,
                                              {NewSum, [NewSum | Acc]}
                                          end, {0, [0]}, Nums),
    PrefixSumsList = lists:reverse(PrefixSumsReversed),

    PrefixSumsArray = array:from_list(PrefixSumsList),

    Averages = lists:map(fun(I) ->
                             StartIdx = I - K,
                             EndIdx = I + K,

                             if
                                 StartIdx < 0 orelse EndIdx >= N ->
                                     -1;
                                 true ->
                                     Sum = array:get(EndIdx + 1, PrefixSumsArray) - array:get(StartIdx, PrefixSumsArray),
                                     Sum div WindowSize
                             end
                         end, lists:seq(0, N - 1)),
    Averages.