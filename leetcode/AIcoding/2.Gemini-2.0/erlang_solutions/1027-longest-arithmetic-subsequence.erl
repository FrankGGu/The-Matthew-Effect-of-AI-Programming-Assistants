-module(longest_arithmetic_subsequence).
-export([longest_arith_seq_length/1]).

longest_arith_seq_length(A) ->
  longest_arith_seq_length(A, length(A)).

longest_arith_seq_length(A, N) ->
  longest_arith_seq_length(A, N, #{}).

longest_arith_seq_length(A, N, DP) ->
  longest_arith_seq_length(A, N, 0, DP).

longest_arith_seq_length(A, N, I, DP) ->
  if
    I >= N ->
      lists:foldl(fun(_, Max) -> Max end, 0, maps:values(DP));
    true ->
      longest_arith_seq_length(A, N, I, update_dp(A, N, I, DP))
  end.

update_dp(A, N, I, DP) ->
  update_dp(A, N, I, I + 1, DP).

update_dp(A, N, I, J, DP) ->
  if
    J >= N ->
      DP;
    true ->
      Diff = lists:nth(J, A) - lists:nth(I, A),
      Key = {I, Diff},
      NewLen =
        case maps:get(Key, DP, undefined) of
          undefined ->
            2;
          Len ->
            Len
        end,
      DP1 = maps:put(Key, NewLen, DP),
      update_dp_inner(A, N, J, Diff, lists:nth(J,A), DP1)
  end.

update_dp_inner(A, N, J, Diff, CurrVal, DP) ->
    K = J + 1,
    update_dp_inner(A, N, J,Diff,CurrVal,K, DP).

update_dp_inner(A, N, J, Diff, CurrVal, K, DP) ->
  if
    K >= N ->
      update_dp(A, N, J + 1, DP);
  lists:nth(K, A) =:= CurrVal + Diff ->
      Key = {J, Diff},
      Len = maps:get(Key, DP, 2),
      KeyNew = {K, Diff},
      NewLen = Len + 1,

      DP1 =
        case maps:get(KeyNew, DP, undefined) of
          undefined ->
            maps:put(KeyNew, NewLen, DP);
          OldLen when NewLen > OldLen ->
            maps:put(KeyNew, NewLen, DP);
          _ ->
             DP
        end,
      update_dp_inner(A, N, J, Diff, CurrVal + Diff, K + 1, DP1);
  true ->
        update_dp_inner(A, N, J, Diff, CurrVal, K + 1, DP)
  end.