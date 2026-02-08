-module(longest_valid_substring).
-export([longest_valid_substring/2]).

longest_valid_substring(Word, Forbidden) ->
  longest_valid_substring(Word, Forbidden, 0).

longest_valid_substring(Word, Forbidden, MaxLen) ->
  case string:len(Word) < 1 of
    true -> MaxLen;
    false ->
      case is_forbidden(Word, Forbidden) of
        true ->
          longest_valid_substring(string:substr(Word, 2), Forbidden, MaxLen);
        false ->
          NewMaxLen = max(MaxLen, string:len(Word)),
          longest_valid_substring(string:substr(Word, 2), Forbidden, NewMaxLen)
      end
  end.

is_forbidden(Word, Forbidden) ->
  lists:any(fun(ForbiddenWord) -> string:str(Word, ForbiddenWord) > 0 end, Forbidden).