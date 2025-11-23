-module(solution).
-export([encode/1]).

encode(Words) ->
    Sorted = lists:sort(Words),
    encode(Sorted, <<>>, 0).

encode([], _, Acc) ->
    Acc;
encode([Word | Rest], Prefix, Acc) ->
    case string:rstr(Prefix, Word) of
        0 ->
            encode(Rest, <<Prefix/binary, Word/binary, $#/binary>>, Acc + erlang:length(Word) + 1);
        _ ->
            encode(Rest, Prefix, Acc)
    end.