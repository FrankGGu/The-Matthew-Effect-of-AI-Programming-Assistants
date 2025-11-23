-module(capitalize_title).
-export([capitalizeTitle/1]).

capitalizeTitle(Title) ->
  Words = string:split(Title, " ", all),
  CapitalizedWords = lists:map(fun(Word) -> capitalizeWord(Word) end, Words),
  string:join(CapitalizedWords, " ").

capitalizeWord(Word) ->
  Len = length(Word),
  case Len < 3 of
    true -> string:to_lower(Word);
    false ->
      FirstChar = string:substr(Word, 1, 1),
      Rest = string:substr(Word, 2, Len - 1),
      string:to_upper(FirstChar) ++ string:to_lower(Rest)
  end.