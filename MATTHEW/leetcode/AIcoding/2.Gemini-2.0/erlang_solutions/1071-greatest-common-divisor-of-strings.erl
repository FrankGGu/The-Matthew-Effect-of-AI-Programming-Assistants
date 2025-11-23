-module(gcd_of_strings).
-export([gcd_of_strings/2]).

gcd_of_strings(Str1, Str2) ->
  case Str1 =:= Str2 of
    true -> Str1;
    false ->
      case string:len(Str1) < string:len(Str2) of
        true -> gcd_of_strings(Str2, Str1);
        false ->
          case string:starts_with(Str1, Str2) of
            true ->
              SubStr = string:substr(Str1, string:len(Str2) + 1);
              gcd_of_strings(SubStr, Str2);
            false ->
              ""
          end
      end
  end.