-module(solution).
-export([new/1, push/2, pop/1, increment/3]).

-record(mystack, {max_size, elements = []}).

new(MaxSize) ->
    #mystack{max_size = MaxSize}.

push(X, #mystack{max_size = MaxSize, elements = Elements} = Stack) ->
    if
        length(Elements) < MaxSize ->
            Stack#mystack{elements = [X|Elements]};
        true ->
            Stack
    end.

pop(#mystack{elements = []} = Stack) ->
    {-1, Stack};

pop(#mystack{elements = [H|T]} = Stack) ->
    {H, Stack#mystack{elements = T}}.

increment(K, Val, #mystack{elements = Elements} = Stack) ->
    Len = length(Elements),
    ActualK = min(K, Len),

    ReversedElements = lists:reverse(Elements),
    {ToIncrement, Rest} = lists:split(ActualK, ReversedElements),

    IncrementedBottom = lists:map(fun(X) -> X + Val end, ToIncrement),

    NewReversedElements = IncrementedBottom ++ Rest,

    NewElements = lists:reverse(NewReversedElements),

    Stack#mystack{elements = NewElements}.