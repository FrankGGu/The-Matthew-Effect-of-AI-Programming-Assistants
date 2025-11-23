-module(number_of_distinct_roll_sequences).
-export([num_roll_sequences/1]).

num_roll_sequences(N) ->
  Mod = 1000000007,
  {Memo, _} = lists:foldl(fun(_, {Acc, CurrentN}) ->
                             NewMemo = dict:new(),
                             {NewMemo, CurrentN + 1}
                         end, {dict:new(), 1}, lists:seq(1, N)),
  num_roll_sequences_helper(N, 0, 0, Memo, Mod).

num_roll_sequences_helper(0, _, _, _, _) ->
  1;
num_roll_sequences_helper(N, LastRoll, SecondLastRoll, Memo, Mod) ->
  Key = {N, LastRoll, SecondLastRoll},
  case dict:find(Key, Memo) of
    {ok, Value} ->
      Value;
    error ->
      Result = lists:foldl(fun(Roll, Acc) ->
                                  if Roll /= LastRoll andalso Roll /= SecondLastRoll andalso gcd(Roll, LastRoll) == 1 then
                                    (Acc + num_roll_sequences_helper(N - 1, Roll, LastRoll, Memo, Mod)) rem Mod
                                  else
                                    Acc
                                  end
                              end, 0, lists:seq(1, 6)),
      NewMemo = dict:store(Key, Result, Memo),
      NewMemo2 = dict:store(Key, Result, NewMemo),
      Result
  end.

gcd(A, 0) ->
  A;
gcd(0, B) ->
  B;
gcd(A, B) ->
  gcd(B, A rem B).