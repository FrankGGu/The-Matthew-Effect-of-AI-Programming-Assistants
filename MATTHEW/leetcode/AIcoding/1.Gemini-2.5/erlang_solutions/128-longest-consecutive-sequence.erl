-module(solution).
-export([longestConsecutive/1]).

longestConsecutive(Nums) ->
    Set = gb_sets:from_list(Nums),
    lists:foldl(fun(N, MaxLenAcc) ->
                    if not gb_sets:is_member(N - 1, Set) ->
                           CurrentNum = N,
                           CurrentLen = 1,
                           SequenceLen = count_consecutive(CurrentNum, CurrentLen, Set),
                           max(MaxLenAcc, SequenceLen);
                       true ->
                           MaxLenAcc
                    end
                end, 0, Nums).

count_consecutive(CurrentNum, CurrentLen, Set) ->
    if gb_sets:is_member(CurrentNum + 1, Set) ->
           count_consecutive(CurrentNum + 1, CurrentLen + 1, Set);
       true ->
           CurrentLen
    end.