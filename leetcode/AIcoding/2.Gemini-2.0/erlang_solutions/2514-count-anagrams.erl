-module(count_anagrams).
-export([num_anagrams/1]).

num_anagrams(S) ->
  Words = string:split(S, " ", all),
  Mod = 1000000000 + 7,
  lists:foldl(
    fun(Word, Acc) ->
      (Acc * count_anagrams_for_word(Word, Mod)) rem Mod
    end,
    1,
    Words
  ).

count_anagrams_for_word(Word, Mod) ->
  Len = length(Word),
  Counts = get_char_counts(Word),
  Factorial = factorial(Len, Mod),
  Divisor = lists:foldl(
    fun({_, Count}, Acc) ->
      (Acc * factorial(Count, Mod)) rem Mod
    end,
    1,
    Counts
  ),
  (Factorial * mod_inverse(Divisor, Mod)) rem Mod.

get_char_counts(Word) ->
  lists:foldl(
    fun(Char, Acc) ->
      case lists:keyfind(Char, 1, Acc) of
        false ->
          [{Char, 1} | Acc];
        {Char, Count} ->
          lists:keyreplace(Char, 1, Acc, {Char, Count + 1})
      end
    end,
    [],
    Word
  ).

factorial(N, Mod) ->
  factorial_helper(N, 1, Mod).

factorial_helper(0, Acc, _) ->
  Acc;
factorial_helper(N, Acc, Mod) ->
  factorial_helper(N - 1, (Acc * N) rem Mod, Mod).

mod_inverse(A, Mod) ->
  power(A, Mod - 2, Mod).

power(Base, Exp, Mod) ->
  power_helper(Base, Exp, 1, Mod).

power_helper(_, 0, Acc, _) ->
  Acc;
power_helper(Base, Exp, Acc, Mod) when Exp rem 2 == 0 ->
  power_helper((Base * Base) rem Mod, Exp div 2, Acc, Mod);
power_helper(Base, Exp, Acc, Mod) ->
  power_helper(Base, Exp - 1, (Acc * Base) rem Mod, Mod).