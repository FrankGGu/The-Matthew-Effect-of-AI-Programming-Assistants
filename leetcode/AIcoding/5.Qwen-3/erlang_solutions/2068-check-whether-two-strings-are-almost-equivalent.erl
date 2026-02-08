-module(solution).
-export([check_almost_equivalent/2]).

check_almost_equivalent(Word1, Word2) ->
    Count1 = count_chars(Word1),
    Count2 = count_chars(Word2),
    check_counts(Count1, Count2).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> 
                    maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                end, #{}, Str).

check_counts(Count1, Count2) ->
    maps:fold(fun(Key, Val1, Acc) ->
                  Val2 = maps:get(Key, Count2, 0),
                  if
                      abs(Val1 - Val2) > 3 -> false;
                      true -> Acc
                  end
              end, true, Count1).

check_counts(_, _) -> true.