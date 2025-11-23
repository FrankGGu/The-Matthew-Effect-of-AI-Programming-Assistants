-module(keyboard_row).
-export([find_words/1]).

find_words(Words) ->
  Row1 = sets:from_list("qwertyuiopQWERTYUIOP"),
  Row2 = sets:from_list("asdfghjklASDFGHJKL"),
  Row3 = sets:from_list("zxcvbnmZXCVBNM"),
  lists:filter(
    fun(Word) ->
      FirstChar = hd(Word),
      case true of
        sets:is_element(FirstChar, Row1) ->
          lists:all(fun(C) -> sets:is_element(C, Row1) end, Word);
        sets:is_element(FirstChar, Row2) ->
          lists:all(fun(C) -> sets:is_element(C, Row2) end, Word);
        sets:is_element(FirstChar, Row3) ->
          lists:all(fun(C) -> sets:is_element(C, Row3) end, Word)
      end
    end,
    Words
  ).