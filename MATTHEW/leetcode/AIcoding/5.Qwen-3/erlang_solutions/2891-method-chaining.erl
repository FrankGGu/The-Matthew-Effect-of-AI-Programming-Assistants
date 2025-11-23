-module(method_chaining).
-export([new/0, add/2, multiply/2, divide/2, result/1]).

new() ->
    {0, 1}.

add(Val, State) ->
    {Val + element(1, State), element(2, State)}.

multiply(Val, State) ->
    {element(1, State) * Val, element(2, State)}.

divide(Val, State) ->
    {element(1, State) / Val, element(2, State)}.

result(State) ->
    element(1, State).