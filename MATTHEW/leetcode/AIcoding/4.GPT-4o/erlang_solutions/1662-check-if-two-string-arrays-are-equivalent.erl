-module(solution).
-export([array_strings_are_equal/2]).

array_strings_are_equal(Strings1, Strings2) ->
    string:join(Strings1, "") =:= string:join(Strings2, "").