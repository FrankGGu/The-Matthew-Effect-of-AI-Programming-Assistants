-module(longest_arithmetic_subsequence).
-export([longestArithSeqLength/2]).

longestArithSeqLength(Arr, Difference) ->
    longestArithSeqLength_helper(Arr, Difference, #{}, 0).

longestArithSeqLength_helper([], _Difference, _Memo, Max) ->
    Max;
longestArithSeqLength_helper([H|T], Difference, Memo, Max) ->
    Len = case maps:get(H - Difference, Memo, 0) of
              0 ->
                  1;
              PrevLen ->
                  PrevLen + 1
          end,
    NewMemo = maps:put(H, Len, Memo),
    NewMax = max(Max, Len),
    longestArithSeqLength_helper(T, Difference, NewMemo, NewMax).