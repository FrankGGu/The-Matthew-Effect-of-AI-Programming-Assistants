-module(guess_the_word).
-export([find_secret_word/2]).

find_secret_word(Wordlist, Master) ->
  find_secret_word_helper(Wordlist, Master, 0).

find_secret_word_helper([Word | Rest], Master, Count) ->
  case Count of
    10 -> ok;
    _ ->
      Guess = Word,
      Matches = Master(Guess),
      case Matches of
        6 ->
          ok;
        _ ->
          find_secret_word_helper([W || W <- Rest, match(W, Guess) == Matches], Master, Count + 1)
      end
  end.

match(Word1, Word2) ->
  match_helper(Word1, Word2, 0).

match_helper([], [], Acc) ->
  Acc;
match_helper([H1 | T1], [H2 | T2], Acc) ->
  case H1 == H2 of
    true ->
      match_helper(T1, T2, Acc + 1);
    false ->
      match_helper(T1, T2, Acc)
  end.