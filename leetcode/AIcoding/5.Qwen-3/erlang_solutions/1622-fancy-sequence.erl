-module(fancy_sequence).
-export([new/0, append/2,addAll/2, multiplyAll/2, getAnElement/2]).

new() ->
    {0, 0, []}.

append(Seq, Val) ->
    {Size, Offset, Data} = Seq,
    NewData = [Val | Data],
    {Size + 1, Offset, NewData}.

addAll(Seq, Val) ->
    {Size, Offset, Data} = Seq,
    NewOffset = Offset + Val,
    {Size, NewOffset, Data}.

multiplyAll(Seq, Val) ->
    {Size, Offset, Data} = Seq,
    NewData = lists:map(fun(X) -> X * Val end, Data),
    {Size, Offset, NewData}.

getAnElement(Seq, Index) ->
    {Size, Offset, Data} = Seq,
    case Index >= 0 andalso Index < Size of
        true ->
            Value = lists:nth(Index + 1, Data),
            Value + Offset;
        false ->
            error(badarg)
    end.