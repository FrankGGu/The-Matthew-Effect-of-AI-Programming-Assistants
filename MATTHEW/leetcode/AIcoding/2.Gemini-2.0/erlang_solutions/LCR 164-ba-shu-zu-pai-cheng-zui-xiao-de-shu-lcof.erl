-module(solution).
-export([crack_password/1]).

crack_password(Passwords) ->
  crack_password(Passwords, []).

crack_password([], Acc) ->
  lists:sort(Acc);
crack_password([Password | Rest], Acc) ->
  case is_valid(Password) of
    true -> crack_password(Rest, [Password | Acc]);
    false -> crack_password(Rest, Acc)
  end.

is_valid(Password) ->
  has_length_between_8_and_12(Password) andalso
  has_at_least_one_uppercase(Password) andalso
  has_at_least_one_lowercase(Password) andalso
  has_at_least_one_digit(Password) andalso
  has_at_least_one_special_character(Password).

has_length_between_8_and_12(Password) ->
  Len = length(Password),
  Len >= 8 andalso Len =< 12.

has_at_least_one_uppercase(Password) ->
  lists:any(fun(C) -> C >= $A andalso C =< $Z end, Password).

has_at_least_one_lowercase(Password) ->
  lists:any(fun(C) -> C >= $a andalso C =< $z end, Password).

has_at_least_one_digit(Password) ->
  lists:any(fun(C) -> C >= $0 andalso C =< $9 end, Password).

has_at_least_one_special_character(Password) ->
  lists:any(fun(C) -> lists:member(C, "!@#$%^&*()-+") end, Password).