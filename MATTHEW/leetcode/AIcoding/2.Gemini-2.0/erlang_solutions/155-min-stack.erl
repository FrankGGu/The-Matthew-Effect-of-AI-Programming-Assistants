-module(min_stack).
-export([new/0, push/2, pop/1, top/1, getMin/1]).

new() ->
    {[], []}.

push({Stack, MinStack}, X) ->
    case MinStack of
        [] ->
            {[X | Stack], [X | MinStack]};
        [Min | _] ->
            if X =< Min then
                {[X | Stack], [X | MinStack]}
            else
                {[X | Stack], [Min | MinStack]}
            end
    end.

pop({Stack, MinStack}) ->
    case Stack of
        [] ->
            {Stack, MinStack};
        [H | RestStack] ->
            case MinStack of
                [] ->
                    {RestStack, MinStack};
                [MinH | RestMinStack] ->
                    if H == MinH then
                        {RestStack, RestMinStack}
                    else
                        {RestStack, RestMinStack}
                    end
            end
    end.

top({Stack, _MinStack}) ->
    case Stack of
        [] ->
            undefined;
        [H | _] ->
            H
    end.

getMin({_Stack, MinStack}) ->
    case MinStack of
        [] ->
            undefined;
        [Min | _] ->
            Min
    end.