-module(OrderedStream).
-export([new/1, insert/2]).

-record(stream, {ptr = 1, data = []}).

new(N) ->
    #stream{data = lists:duplicate(N, undefined)}.

insert(#stream{ptr = Ptr, data = Data} = Stream, id, value) ->
    NewData = lists:replace_element(id, value, Data),
    NewPtr = case lists:find_index(fun(X) -> X =/= undefined end, NewData) of
        none -> Ptr;
        {ok, Index} -> Index + 1
    end,
    {NewData, #stream{Stream#stream{ptr = NewPtr, data = NewData}}}.

get_chunks(#stream{ptr = Ptr, data = Data}) ->
    {Chunk, NewData} = lists:splitwhile(fun(X) -> X =/= undefined end, Data),
    {Chunk, #stream{ptr = Ptr + length(Chunk), data = NewData}}.