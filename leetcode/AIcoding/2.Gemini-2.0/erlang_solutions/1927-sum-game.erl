-module(sum_game).
-export([predict_the_winner/1]).

predict_the_winner(Num) ->
  Len = length(Num),
  QuesCount = lists:foldl(fun(N, Acc) -> if N == ?? then Acc + 1 else Acc end, 0, Num),
  SumDiff = lists:foldl(fun(N, Acc) -> if N /= ?? then Acc + N else Acc end, 0, lists:sublist(Num, 1, Len div 2)) - lists:foldl(fun(N, Acc) -> if N /= ?? then Acc + N else Acc end, 0, lists:sublist(Num, Len div 2 + 1, Len div 2)),
  if QuesCount rem 2 == 1 then
    true
  else
    QuesDiff = QuesCount div 2,
    SumDiff = SumDiff + QuesDiff * 9 / 2,
    SumDiff /= 0
  end.