-module(maximize_score).
-export([max_score/1]).

max_score(Nums) ->
  N = length(Nums),
  memo(Nums, N div 2, 1, lists:seq(1, N), #{}).

memo(_Nums, 0, _Op, _Remaining, Memo) ->
  maps:get({0, _Op}, Memo, 0);
memo(Nums, Op, _OpMax, Remaining, Memo) ->
  case maps:get({Remaining, Op}, Memo, undefined) of
    undefined ->
      Result = lists:foldl(
                 fun (I, MaxScore) ->
                   lists:foldl(
                     fun (J, CurrentMaxScore) ->
                       if I >= J then
                         CurrentMaxScore
                       else
                         GCD = gcd(lists:nth(I, Nums), lists:nth(J, Nums)),
                         NewRemaining = lists:delete(I, lists:delete(J, Remaining)),
                         NewScore = Op * GCD + memo(Nums, Op - 1, _OpMax, NewRemaining, Memo),
                         max(CurrentMaxScore, NewScore)
                       end
                     end,
                     MaxScore,
                     Remaining
                   )
                 end,
                 0,
                 Remaining
               ),
      maps:put({Remaining, Op}, Result, Memo);
    Value ->
      Value
  end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).