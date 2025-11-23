-module(solution).
-export([isLongPressedName/2]).

isLongPressedName(Name, Typed) ->
    check(Name, Typed, undefined).

check([], [], _LastTypedChar) ->
    true;

check([], [TH|TT], LastTypedChar) when TH == LastTypedChar ->
    check([], TT, TH);

check([], _Typed, _LastTypedChar) ->
    false;

check([NH|NT], [TH|TT], _LastTypedChar) when NH == TH ->
    check(NT, TT, TH);

check(Name, [TH|TT], LastTypedChar) when TH == LastTypedChar ->
    check(Name, TT, TH);

check(_Name, _Typed, _LastTypedChar) ->
    false.