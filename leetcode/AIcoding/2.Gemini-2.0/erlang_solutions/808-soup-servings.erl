-module(soup_servings).
-export([soup_servings/1]).

soup_servings(N) ->
  M = math:ceil(N / 25),
  case M > 100 of
    true -> 1.0;
    false ->
      memo(M, #{ {0, 0} => 0.0 }, 1, 1)
  end.

memo(M, Memo, A, B) ->
  case maps:is_key({A, B}, Memo) of
    true ->
      maps:get({A, B}, Memo);
    false ->
      Result = calculate(M, Memo, A, B),
      memo(M, maps:put({A, B}, Result, Memo), A, B)
  end.

calculate(M, Memo, A, B) ->
  case {A > M, B > M} of
    {true, true} -> 0.5;
    {true, false} -> 0.0;
    {false, true} -> 1.0;
    {false, false} ->
      P1 = memo(M, Memo, A + 4, B);
      P2 = memo(M, Memo, A + 3, B + 1);
      P3 = memo(M, Memo, A + 2, B + 2);
      P4 = memo(M, Memo, A + 1, B + 3);
      0.25 * (P1 + P2 + P3 + P4)
  end.