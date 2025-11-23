-module(last_visited_integers).
-export([last_visited_integers/1]).

last_visited_integers(Words) ->
    last_visited_integers(Words, [], []).

last_visited_integers([], _, Acc) ->
    lists:reverse(Acc);
last_visited_integers(["prev"|Rest], Numbers, Acc) ->
    Len = length(Numbers);
    case Len > 0 of
        true ->
            last_visited_integers(Rest, Numbers, [lists:nth(Len, lists:reverse(Numbers))|Acc]);
        false ->
            last_visited_integers(Rest, Numbers, [-1|Acc])
    end;
last_visited_integers([Word|Rest], Numbers, Acc) ->
    try
        Num = list_to_integer(Word),
        last_visited_integers(Rest, [Num|Numbers], Acc)
    catch
        _:_ ->
            last_visited_integers(Rest, Numbers, Acc)
    end.