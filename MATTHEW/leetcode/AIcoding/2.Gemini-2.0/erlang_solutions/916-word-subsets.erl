-module(word_subsets).
-export([word_subsets/2]).

word_subsets(A, B) ->
  B_max_freq = lists:foldl(
    fun(Word, Acc) ->
      lists:foldl(
        fun(Char, Acc2) ->
          CharFreq = word_freq(Word),
          lists:update_with(
            Char,
            fun(Freq) -> max(Freq, maps:get(Char, CharFreq, 0)) end,
            fun(_) -> maps:get(Char, CharFreq, 0) end,
            Acc2
          )
        end,
        Acc,
        lists:usort(string:characters(Word))
      )
    end,
    #{},
    B
  ),
  lists:filter(
    fun(Word) ->
      WordFreq = word_freq(Word),
      maps:all(
        fun(Char, Freq) ->
          maps:get(Char, WordFreq, 0) >= Freq
        end,
        B_max_freq
      )
    end,
    A
  ).

word_freq(Word) ->
  lists:foldl(
    fun(Char, Acc) ->
      maps:update_with(Char, fun(X) -> X + 1 end, fun(_) -> 1 end, Acc)
    end,
    #{},
    string:characters(Word)
  ).