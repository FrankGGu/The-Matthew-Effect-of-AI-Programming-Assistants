-module(ordered_stream).
-export([init/1, insert/3]).

init(N) ->
    Data = lists:duplicate(N, undefined),
    {1, Data, N}.

insert({Ptr, Data, N}, IdKey, Value) ->
    NewData = lists:replace_nth(IdKey, Value, Data),
    {CollectedValues, NewPtr} = collect_and_update_ptr(Ptr, NewData, N, []),
    {CollectedValues, {NewPtr, NewData, N}}.

collect_and_update_ptr(CurrentPtr, Data, N, Acc) ->
    if
        CurrentPtr > N ->
            {lists:reverse(Acc), N + 1};
        true ->
            Element = lists:nth(CurrentPtr, Data),
            if
                Element == undefined ->
                    {lists:reverse(Acc), CurrentPtr};
                true ->
                    collect_and_update_ptr(CurrentPtr + 1, Data, N, [Element | Acc])
            end
    end.