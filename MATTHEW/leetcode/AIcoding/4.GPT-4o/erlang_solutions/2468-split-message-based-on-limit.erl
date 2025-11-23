-module(solution).
-export([split_message/2]).

split_message(Message, Limit) ->
    split_message(Message, Limit, 1, []).

split_message(<<>>, _Limit, _Index, Acc) ->
    lists:reverse(Acc);
split_message(Message, Limit, Index, Acc) ->
    case byte_size(Message) of
        Size when Size =< Limit ->
            lists:reverse([<<Index, ": ", Message>> | Acc]);
        _ ->
            {Chunk, Rest} = binary:split(Message, <<0:Limit/binary>>, [{return, binary}, {global, true}]),
            lists:reverse([<<Index, ": ", Chunk>> | Acc]) ++ split_message(Rest, Limit, Index + 1, [])
    end.