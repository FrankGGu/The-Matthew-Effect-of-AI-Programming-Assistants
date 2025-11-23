-module(ordered_stream).
-export([new/1, insert/3]).

new(N) ->
    {array:new(N+1), 1}.

insert({Stream, Ptr}, Id, Value) ->
    NewStream = array:set(Id, Value, Stream),
    {NewStream,
     case array:is_defined(Ptr, NewStream) of
         true ->
             {NewPtr, Result} = process_chunk(NewStream, Ptr, []);
             {NewStream, NewPtr, lists:reverse(Result)};
         false ->
             {NewStream, Ptr, []}
     end}.

process_chunk(Stream, Ptr, Acc) ->
    case array:is_defined(Ptr, Stream) of
        true ->
            process_chunk(Stream, Ptr + 1, [array:get(Ptr, Stream) | Acc]);
        false ->
            {Ptr, Acc}
    end.