-module(palindrome_partitioning_ii).
-export([min_cut/1]).

min_cut(S) ->
  Len = length(S),
  P = create_palindrome_table(S, Len),
  DP = lists:duplicate(Len + 1, 0),
  DP_update(Len - 1, Len, P, DP).

DP_update(-1, _, _, DP) ->
  lists:nth(1, DP) - 1;
DP_update(I, Len, P, DP) ->
  Min = lists:foldl(fun(J, Acc) ->
                      if lists:nth(I + 1, lists:nth(J + 1, P)) == 1 ->
                        min(Acc, lists:nth(J + 2, DP))
                      else
                        Acc
                      end
                    end, Len, lists:seq(I, Len - 1)),
  DP1 = lists:replace(I + 1, Min + 1, DP),
  DP_update(I - 1, Len, P, DP1).

create_palindrome_table(S, Len) ->
  P = lists:duplicate(Len, lists:duplicate(Len, 0)),
  create_palindrome_table_helper(0, Len, S, P).

create_palindrome_table_helper(I, Len, S, P) ->
  if I >= Len then
    P
  else
    P1 = create_palindrome_table_helper2(I, I, Len, S, P),
    create_palindrome_table_helper(I + 1, Len, S, P1)
  end.

create_palindrome_table_helper2(L, R, Len, S, P) ->
  if L >= 0 and R < Len and lists:nth(L + 1, string:to_list(S)) == lists:nth(R + 1, string:to_list(S)) then
    P1 = lists:replace(L + 1, lists:replace(R + 1, 1, lists:nth(L + 1, P)), P),
    create_palindrome_table_helper2(L - 1, R + 1, Len, S, P1)
  else
    P
  end.