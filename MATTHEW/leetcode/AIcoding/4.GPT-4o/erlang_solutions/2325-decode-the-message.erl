-module(solution).
-export([decode_message/2]).

decode_message(Key, Message) ->
    decode(Key, Message, <<>>).

decode([], _, Acc) -> Acc;
decode([H | T], <<M:8, Rest/binary>>, Acc) ->
    case M of
        $' ' -> decode(T, Rest, <<Acc/binary, M>>);
        _ -> 
            NewChar = case lists:member(M, T) of
                true -> <<65 + lists:position(M, T) - 1>>;
                false -> <<M>>
            end,
            decode(T, Rest, <<Acc/binary, NewChar/binary>>)
    end.