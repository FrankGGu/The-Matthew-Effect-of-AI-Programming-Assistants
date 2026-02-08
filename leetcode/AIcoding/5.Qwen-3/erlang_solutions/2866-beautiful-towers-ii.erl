-module(beautiful_towers_ii).
-export([maximal_rectangle/1]).

maximal_rectangle(Histogram) ->
    Max = 0,
    Stack = [],
    Height = [0 | Histogram ++ [0]],
    maximal_rectangle(Height, Stack, Max).

maximal_rectangle([], _, Max) ->
    Max;
maximal_rectangle([H | T], Stack, Max) ->
    NewStack = pop_stack(Stack, H),
    Area = if
        NewStack == [] -> H * length(T);
        true -> H * (length(T) - hd(NewStack) - 1)
    end,
    NewMax = max(Max, Area),
    maximal_rectangle(T, [length(T) | NewStack], NewMax).

pop_stack([], H) ->
    [];
pop_stack([Top | Rest], H) when H >= lists:nth(Top + 1, [0 | [H | _]]) ->
    pop_stack(Rest, H);
pop_stack(Stack, H) ->
    Stack.