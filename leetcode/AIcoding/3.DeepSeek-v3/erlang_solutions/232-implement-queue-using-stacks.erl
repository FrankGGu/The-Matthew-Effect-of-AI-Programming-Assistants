-module(queue_using_stacks).
-export([init/0, push/2, pop/1, peek/1, empty/1]).

init() ->
    {[], []}.

push({In, Out}, X) ->
    {[X | In], Out}.

pop({In, Out}) ->
    case Out of
        [] ->
            case In of
                [] -> {error, empty};
                _ ->
                    NewOut = lists:reverse(In),
                    [H | T] = NewOut,
                    {H, {[], T}}
            end;
        [H | T] ->
            {H, {In, T}}
    end.

peek({In, Out}) ->
    case Out of
        [] ->
            case In of
                [] -> error;
                _ ->
                    NewOut = lists:reverse(In),
                    hd(NewOut)
            end;
        [H | _] ->
            H
    end.

empty({In, Out}) ->
    In == [] andalso Out == [].