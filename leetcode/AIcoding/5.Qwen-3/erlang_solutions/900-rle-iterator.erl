-module(rle_iterator).
-export([new/1, next/2]).

-record(iterator, {indices, values, pos = 0}).

new(Sequence) ->
    Indices = lists:seq(1, length(Sequence), 2),
    Values = lists:seq(2, length(Sequence), 2),
    #iterator{indices = lists:map(fun(I) -> lists:nth(I, Sequence) end, Indices), 
              values = lists:map(fun(V) -> lists:nth(V, Sequence) end, Values)}.

next(Count, Iterator) ->
    Remaining = Count,
    Value = next_value(Remaining, Iterator#iterator.indices, Iterator#iterator.values, Iterator#iterator.pos),
    case Value of
        none -> none;
        {Val, NewPos} ->
            Iterator#iterator{pos = NewPos},
            Val
    end.

next_value(_Remaining, [], [], _Pos) -> none;
next_value(Remaining, [I | Is], [V | Vs], Pos) ->
    if
        Pos < I ->
            case I - Pos of
                N when N =< Remaining ->
                    next_value(Remaining - N, Is, Vs, I);
                _ ->
                    {V, Pos + Remaining}
            end;
        true ->
            next_value(Remaining, Is, Vs, Pos)
    end.