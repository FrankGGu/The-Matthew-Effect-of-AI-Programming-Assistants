-module(memory_allocator).
-export([new/0, allocate/3, free/2]).

new() ->
    {dict:new(), 0}.

allocate(Addr, Size, Mem) ->
    {Dict, MaxAddr} = Mem,
    case dict:find(Addr, Dict) of
        {ok, _} -> {Mem, false};
        error ->
            case can_allocate(Dict, Addr, Size) of
                true ->
                    NewDict = dict:store(Addr, Size, Dict),
                    NewMaxAddr = max(MaxAddr, Addr + Size - 1),
                    {NewDict, NewMaxAddr, true};
                false ->
                    {Mem, false}
            end
    end.

free(Addr, Mem) ->
    {Dict, MaxAddr} = Mem,
    case dict:find(Addr, Dict) of
        {ok, Size} ->
            NewDict = dict:erase(Addr, Dict),
            {NewDict, MaxAddr, true};
        error ->
            {Mem, false}
    end.

can_allocate(Dict, Addr, Size) ->
    Start = Addr,
    End = Addr + Size - 1,
    lists:all(fun({A, B}) -> not (A < End andalso B > Start) end, dict:to_list(Dict)).