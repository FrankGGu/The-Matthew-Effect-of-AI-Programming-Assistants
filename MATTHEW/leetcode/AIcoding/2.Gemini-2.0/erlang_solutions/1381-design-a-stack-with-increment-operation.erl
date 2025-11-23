-module(custom_stack).
-export([constructor, push, pop, increment]).

constructor(MaxCapacity) ->
    {ok, {[], MaxCapacity}}.

push(Val, {Stack, MaxCapacity}) ->
    case length(Stack) < MaxCapacity of
        true ->
            {ok, {[Val | Stack], MaxCapacity}};
        false ->
            {error, "Stack is full", {Stack, MaxCapacity}}
    end.

pop({[], MaxCapacity}) ->
    {ok, -1, {[], MaxCapacity}};
pop({[H | T], MaxCapacity}) ->
    {ok, H, {T, MaxCapacity}}.

increment(K, Val, {Stack, MaxCapacity}) ->
    increment_helper(Stack, K, Val, [], {[], MaxCapacity}).

increment_helper([], _K, _Val, Acc, State) ->
    {ok, lists:reverse(Acc), State};
increment_helper(Stack, K, Val, Acc, State) ->
    case K > 0 of
        true ->
            case length(Stack) =:= K of
                true ->
                    increment_all(Stack, Val, Acc, State);
                false ->
                    [H | T] = Stack,
                    increment_helper(T, K - 1, Val, [H + Val | Acc], State)
            end;
        false ->
            increment_all(Stack, Val, Acc, State)
    end.

increment_all(Stack, Val, Acc, State) ->
    {ok, lists:reverse([X + Val || X <- Stack]) ++ lists:reverse(Acc), State}.