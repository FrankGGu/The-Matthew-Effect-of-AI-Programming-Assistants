-module(my_calendar).
-export([init/0, book/3]).

init() ->
    [].

book(Calendar, Start, End) ->
    case has_overlap(Calendar, Start, End) of
        true ->
            {false, Calendar};
        false ->
            {true, [{Start, End} | Calendar]}
    end.

has_overlap([], _NewStart, _NewEnd) ->
    false;
has_overlap([{ExistingStart, ExistingEnd} | Rest], NewStart, NewEnd) ->
    if
        NewStart < ExistingEnd andalso ExistingStart < NewEnd ->
            true;
        true ->
            has_overlap(Rest, NewStart, NewEnd)
    end.