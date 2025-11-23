-module(front_middle_back_queue).
-export([init/0, push_front/2, push_middle/2, push_back/2, pop_front/1, pop_middle/1, pop_back/1]).

init() ->
    {[], []}.

push_front(Queue, Val) ->
    {Front, Back} = Queue,
    {[Val | Front], Back}.

push_middle(Queue, Val) ->
    {Front, Back} = Queue,
    LenF = length(Front),
    LenB = length(Back),
    if
        LenF =:= LenB ->
            {Front, [Val | Back]};
        true ->
            [H | T] = Front,
            {T, [H, Val | Back]}
    end.

push_back(Queue, Val) ->
    {Front, Back} = Queue,
    {Front, Back ++ [Val]}.

pop_front(Queue) ->
    {Front, Back} = Queue,
    case {Front, Back} of
        {[], []} ->
            {-1, {[], []}};
        {[], [H | T]} ->
            {H, {[], T}};
        {[H | T], Back} ->
            {H, {T, Back}}
    end.

pop_middle(Queue) ->
    {Front, Back} = Queue,
    LenF = length(Front),
    LenB = length(Back),
    if
        LenF + LenB =:= 0 ->
            {-1, {[], []}};
        LenF =:= LenB ->
            [H | T] = Back,
            {H, {Front, T}};
        true ->
            [H | T] = Front,
            {H, {T, Back}}
    end.

pop_back(Queue) ->
    {Front, Back} = Queue,
    case {Front, Back} of
        {[], []} ->
            {-1, {[], []}};
        {Front, []} ->
            [H | T] = lists:reverse(Front),
            {H, {lists:reverse(T), []}};
        {Front, [H | T]} when T =:= [] ->
            case Front of
                [] ->
                    {H, {[], []}};
                _ ->
                    [Last | Rest] = lists:reverse(Front),
                    {H, {lists:reverse(Rest), []}}
            end;
        {Front, Back} ->
            [H | T] = lists:reverse(Back),
            {H, {Front, lists:reverse(T)}}
    end.