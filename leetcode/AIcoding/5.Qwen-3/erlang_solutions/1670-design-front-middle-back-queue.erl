-module(front_middle_back_queue).
-export([new/0, push_front/2, push_middle/2, push_back/2, pop_front/1, pop_middle/1, pop_back/1]).

new() ->
    {[], []}.

push_front(X, {Front, Back}) ->
    { [X | Front], Back }.

push_middle(X, {Front, Back}) ->
    Len = length(Front) + length(Back),
    if
        Len rem 2 == 0 ->
            { Front ++ [X], Back };
        true ->
            { Front, [X | Back] }
    end.

push_back(X, {Front, Back}) ->
    { Front, [X | Back] }.

pop_front({[], []}) ->
    {error, empty};
pop_front({[H | T], Back}) ->
    {H, {T, Back}}.

pop_middle({[], []}) ->
    {error, empty};
pop_middle({Front, Back}) ->
    Len = length(Front) + length(Back),
    Mid = (Len - 1) div 2,
    case Mid < length(Front) of
        true ->
            { lists:nth(Mid + 1, Front), { lists:sublist(Front, Mid) ++ lists:sublist(Front, Mid + 2, length(Front) - Mid - 1), Back } };
        false ->
            Offset = Mid - length(Front),
            { lists:nth(Offset + 1, Back), { Front, lists:sublist(Back, Offset) ++ lists:sublist(Back, Offset + 2, length(Back) - Offset - 1) } }
    end.

pop_back({[], []}) ->
    {error, empty};
pop_back({Front, [H | T]}) ->
    {H, {Front, T}}.