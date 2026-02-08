-module(uncrossed_lines).
-export([max_uncrossed_lines/2]).

max_uncrossed_lines(A, B) ->
  max_uncrossed_lines(A, B, length(A), length(B)).

max_uncrossed_lines(A, B, M, N) ->
  memo(A, B, M, N, dict:new()).

memo(A, B, 0, _, Dict) ->
  dict:store({0, N}, 0, Dict);
memo(_, _, _, 0, Dict) ->
  dict:store({M, 0}, 0, Dict);
memo(A, B, M, N, Dict) ->
  case dict:is_key({M, N}, Dict) of
    true ->
      dict:fetch({M, N}, Dict);
    false ->
      Val =
        if lists:nth(M, A) == lists:nth(N, B) then
          memo(A, B, M - 1, N - 1, Dict) + 1
        else
          max(memo(A, B, M - 1, N, Dict), memo(A, B, M, N - 1, Dict))
        end,
      dict:store({M, N}, Val, Dict),
      Val
  end.

max(A, B) when A > B -> A;
max(_, B) -> B.