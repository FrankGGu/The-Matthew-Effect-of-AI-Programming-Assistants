-module(maximize_palindrome_length_from_subsequences).
-export([max_palindrome_length/2]).

max_palindrome_length(Word1, Word2) ->
  Words = Word1 ++ Word2,
  N1 = length(Word1),
  N = length(Words),
  memo(N, N, Words, N1, dict:new()).

memo(I, J, Words, N1, Memo) when I > J ->
  0;
memo(I, J, Words, N1, Memo) ->
  case dict:find({I, J}, Memo) of
    {ok, Val} ->
      Val;
    error ->
      case lists:nth(I, lists:seq(1, length(Words))) of
        _ when lists:nth(I, Words) == lists:nth(J, Words) ->
          case (I =< N1) and (J > N1) of
            true ->
              Result = 2 + memo(I + 1, J - 1, Words, N1, Memo);
            false ->
              Result = memo(I + 1, J - 1, Words, N1, Memo)
          end;
        _ ->
          Result = max(memo(I + 1, J, Words, N1, Memo), memo(I, J - 1, Words, N1, Memo))
      end,
      NewMemo = dict:store({I, J}, Result, Memo),
      NewMemo2 = dict:store({I, J}, Result, Memo),
      Result
  end.