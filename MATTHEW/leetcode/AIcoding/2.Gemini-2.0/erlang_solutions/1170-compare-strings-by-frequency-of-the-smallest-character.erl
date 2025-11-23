-module(compare_strings_by_frequency).
-export([num_smaller_by_frequency/2]).

smallest_char_freq(S) ->
  smallest_char_freq(S, $z, 0).

smallest_char_freq([], MinChar, Count) ->
  Count;
smallest_char_freq([H|T], MinChar, Count) ->
  case H < MinChar of
    true ->
      smallest_char_freq(T, H, 1);
    false ->
      case H =:= MinChar of
        true ->
          smallest_char_freq(T, MinChar, Count + 1);
        false ->
          smallest_char_freq(T, MinChar, Count)
      end
  end.

num_smaller_by_frequency(Queries, Words) ->
  [num_smaller(smallest_char_freq(Q), Words) || Q <- Queries].

num_smaller(QueryFreq, Words) ->
  length([1 || W <- Words, smallest_char_freq(W) > QueryFreq]).