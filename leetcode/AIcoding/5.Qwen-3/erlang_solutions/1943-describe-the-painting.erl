-module(painting).
-export([describe_painting/1]).

describe_painting(Paintings) ->
    PaintingsList = lists:sort([{Start, End, Index} || {Index, {Start, End}} <- lists:enumerate(1, Paintings)]),
    Result = process_paintings([], PaintingsList),
    lists:map(fun({Start, End, Index}) -> {Start, End, Index} end, Result).

process_paintings(Acc, []) ->
    Acc;
process_paintings(Acc, [H | T]) ->
    {Start, End, Index} = H,
    case Acc of
        [] ->
            process_paintings([H], T);
        _ ->
            Last = lists:last(Acc),
            {LStart, LEnd, LIndex} = Last,
            if
                Start > LEnd ->
                    process_paintings([H | Acc], T);
                true ->
                    NewStart = min(Start, LStart),
                    NewEnd = max(End, LEnd),
                    NewAcc = lists:sublist(Acc, length(Acc) - 1) ++ [{NewStart, NewEnd, LIndex}],
                    process_paintings([H | NewAcc], T)
            end
    end.