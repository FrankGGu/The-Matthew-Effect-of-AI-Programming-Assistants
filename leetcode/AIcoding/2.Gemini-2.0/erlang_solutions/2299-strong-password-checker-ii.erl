-module(strong_password_checker_ii).
-export([strongPasswordCheckerII/1]).

strongPasswordCheckerII(Password) ->
  Len = length(Password),
  Len >= 8 and hasLowerCase(Password) and hasUpperCase(Password) and hasDigit(Password) and hasSpecialCharacter(Password) and isNoConsecutive(Password).

hasLowerCase(Password) ->
  lists:any(fun(C) -> C >= $a andalso C =< $z end, Password).

hasUpperCase(Password) ->
  lists:any(fun(C) -> C >= $A andalso C =< $Z end, Password).

hasDigit(Password) ->
  lists:any(fun(C) -> C >= $0 andalso C =< $9 end, Password).

hasSpecialCharacter(Password) ->
  SpecialCharacters = "!@#$%^&*()-+",
  lists:any(fun(C) -> lists:member(C, SpecialCharacters) end, Password).

isNoConsecutive(Password) ->
  isNoConsecutive(Password, []).

isNoConsecutive([], _) ->
  true;
isNoConsecutive([_], _) ->
  true;
isNoConsecutive([H1, H2 | T], Acc) ->
  if
    H1 == H2 ->
      false;
    true ->
      isNoConsecutive([H2 | T], [H1 | Acc])
  end.