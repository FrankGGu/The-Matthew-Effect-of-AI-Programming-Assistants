-module(my_calendar).
-export([new/0, book/2]).

new() ->
    [].

book(Calendar, Start, End) ->
    case check_overlap(Calendar, Start, End) of
        true ->
            {false, Calendar};
        false ->
            {true, insert_event(Calendar, Start, End)}
    end.

check_overlap([], _Start, _End) ->
    false;
check_overlap([[S, E] | Rest], Start, End) ->
    case (Start < E) and (S < End) of
        true ->
            true;
        false ->
            check_overlap(Rest, Start, End)
    end.

insert_event(Calendar, Start, End) ->
    insert_event_helper(Calendar, Start, End, []).

insert_event_helper([], Start, End, Acc) ->
    lists:reverse([[Start, End] | Acc]);
insert_event_helper([[S, E] | Rest], Start, End, Acc) ->
    case Start < S of
        true ->
            lists:reverse([[Start, End] | lists:reverse([[S, E] | Acc]) ] ++ Rest);
        false ->
            insert_event_helper(Rest, Start, End, [[S, E] | Acc])
    end.