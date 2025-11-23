-module(valid_permutations).
-export([num_permutations_di_sequence/1]).

num_permutations_di_sequence(S) ->
  N = length(S) + 1,
  memo = dict:new(),
  num_permutations_di_sequence_helper(S, lists:seq(1, N), memo).

num_permutations_di_sequence_helper(_S, [], _Memo) ->
  1;
num_permutations_di_sequence_helper(S, Remaining, Memo) ->
  Key = {S, Remaining},
  case dict:find(Key, Memo) of
    {ok, Value} ->
      Value;
    error ->
      Result = calculate_permutations(S, Remaining, Memo),
      dict:store(Key, Result, Memo),
      Result
  end.

calculate_permutations([], [_], _Memo) ->
  1;
calculate_permutations([], [], _Memo) ->
  1;

calculate_permutations([H|T], Remaining, Memo) ->
  Sum = lists:foldl(
          fun(Num, Acc) ->
              case check_condition(H, Num, Remaining) of
                  true ->
                      RemainingWithoutNum = lists:delete(Num, Remaining),
                      Acc + num_permutations_di_sequence_helper(T, RemainingWithoutNum, Memo) rem 1000000007;
                  false ->
                      Acc
              end
          end,
          0,
          Remaining
         ),
  Sum rem 1000000007.

check_condition(H, Num, Remaining) ->
  case H of
    $I ->
      lists:any(fun(X) -> X > Num end, Remaining);
    $D ->
      lists:any(fun(X) -> X < Num end, Remaining);
    _ ->
      false
  end.