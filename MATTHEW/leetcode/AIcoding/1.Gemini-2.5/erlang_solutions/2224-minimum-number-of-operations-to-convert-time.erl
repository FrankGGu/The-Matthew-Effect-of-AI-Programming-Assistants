-module(solution).
-export([convert_time/2]).

convert_time(Current, Correct) ->
    [CH_str, CM_str] = string:tokens(Current, ":"),
    CurrentMinutes = list_to_integer(CH_str) * 60 + list_to_integer(CM_str),

    [RH_str, RM_str] = string:tokens(Correct, ":"),
    CorrectMinutes = list_to_integer(RH_str) * 60 + list_to_integer(RM_str),

    Diff = CorrectMinutes - CurrentMinutes,

    Ops60 = Diff div 60,
    Rem60 = Diff rem 60,

    Ops15 = Rem60 div 15,
    Rem15 = Rem60 rem 15,

    Ops5 = Rem15 div 5,
    Rem5 = Rem15 rem 5,

    Ops1 = Rem5,

    Ops60 + Ops15 + Ops5 + Ops1.