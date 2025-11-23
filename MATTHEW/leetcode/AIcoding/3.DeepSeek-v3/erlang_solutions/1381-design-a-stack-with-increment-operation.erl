-module(custom_stack).
-export([init/1, push/2, pop/1, increment/3]).

-record(stack, {max_size, stack = []}).

init(MaxSize) ->
    #stack{max_size = MaxSize}.

push(Stack = #stack{max_size = MaxSize, stack = S}, X) ->
    case length(S) < MaxSize of
        true -> Stack#stack{stack = [X | S]};
        false -> Stack
    end.

pop(Stack = #stack{stack = []}) ->
    {-1, Stack};
pop(Stack = #stack{stack = [H | T]}) ->
    {H, Stack#stack{stack = T}}.

increment(Stack = #stack{stack = S}, K, Val) ->
    {Prefix, Suffix} = lists:split(max(0, length(S) - K), S),
    NewSuffix = lists:map(fun(X) -> X + Val end, Suffix),
    Stack#stack{stack = Prefix ++ NewSuffix}.