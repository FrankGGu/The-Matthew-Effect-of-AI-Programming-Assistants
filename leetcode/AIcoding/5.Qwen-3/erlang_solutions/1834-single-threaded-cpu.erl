-module(solve).
-export([get_times/1]).

get_times(Instructions) ->
    get_times(Instructions, [], 0, 0).

get_times([], [], _Time, Acc) ->
    lists:reverse(Acc);
get_times(Instructions, [], Time, Acc) ->
    [Next | Rest] = Instructions,
    {Pid, Cycles} = Next,
    get_times(Rest, [{Pid, Cycles, Time}], Time + Cycles, [Pid | Acc]);
get_times(Instructions, Queue, Time, Acc) ->
    {Ready, Waiting} = lists:partition(fun({Pid, Cycles, Start}) -> Start =< Time end, Queue),
    if
        Ready == [] ->
            [Next | Rest] = Instructions,
            {Pid, Cycles} = Next,
            get_times(Rest, [{Pid, Cycles, Time}], Time + Cycles, [Pid | Acc]);
        true ->
            {Best, Remaining} = pick_best(Ready),
            {Pid, Cycles, Start} = Best,
            NewTime = Time + Cycles,
            get_times(Instructions, Remaining ++ Waiting, NewTime, [Pid | Acc])
    end.

pick_best(Queue) ->
    lists:foldl(fun(Elem, {Best, []}) ->
                    case Elem of
                        {Pid1, Cycles1, _} when Cycles1 < element(2, Best) ->
                            {Elem, []};
                        _ ->
                            {Best, [Elem]}
                    end;
                (Elem, {Best, Acc}) ->
                    case Elem of
                        {Pid1, Cycles1, _} when Cycles1 < element(2, Best) ->
                            {Elem, [Best | Acc]};
                        _ ->
                            {Best, [Elem | Acc]}
                    end
            end, hd(Queue), tl(Queue)).