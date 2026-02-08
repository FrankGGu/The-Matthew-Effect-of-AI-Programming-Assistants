-module(ordered_stream).
-export([init/1, insert/3]).

-record(stream, {
    ptr = 1 :: integer(),
    chunks = #{} :: map()
}).

-spec init(N :: integer()) -> any().
init(_N) ->
    #stream{}.

-spec insert(IdKey :: integer(), Value :: unicode:unicode_binary(), Obj :: #stream{}) -> [unicode:unicode_binary()].
insert(IdKey, Value, #stream{ptr = Ptr, chunks = Chunks} = Stream) ->
    NewChunks = maps:put(IdKey, Value, Chunks),
    case IdKey of
        Ptr ->
            Result = collect_chunks(Ptr, NewChunks, []),
            NewPtr = Ptr + length(Result),
            {Result, Stream#stream{ptr = NewPtr, chunks = NewChunks}};
        _ ->
            {[], Stream#stream{chunks = NewChunks}}
    end.

collect_chunks(Ptr, Chunks, Acc) ->
    case maps:get(Ptr, Chunks, undefined) of
        undefined ->
            lists:reverse(Acc);
        Value ->
            collect_chunks(Ptr + 1, Chunks, [Value | Acc])
    end.