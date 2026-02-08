-module(ordered_stream).
-export([new/1, insert/2, get_next/1]).

-record(stream, {ptr = 0, data = dict:new()}).

new(InitialSize) ->
    #stream{}.

insert(Stream, {Index, Value}) ->
    Data = Stream#stream.data,
    NewData = dict:store(Index, Value, Data),
    Stream#stream{data = NewData}.

get_next(Stream) ->
    Ptr = Stream#stream.ptr,
    Data = Stream#stream.data,
    case dict:is_key(Ptr, Data) of
        true ->
            Value = dict:fetch(Ptr, Data),
            NewStream = Stream#stream{ptr = Ptr + 1},
            [Value | get_next(NewStream)];
        false ->
            []
    end.