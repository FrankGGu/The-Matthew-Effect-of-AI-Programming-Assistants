-module(string_arrays_equivalent).
-export([arrayStringsAreEqual/2]).

arrayStringsAreEqual(Word1, Word2) ->
  string:join(Word1, "") == string:join(Word2, "").