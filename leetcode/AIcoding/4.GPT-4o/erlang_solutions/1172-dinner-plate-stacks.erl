-module(solution).
-export([DinnerPlateStacks/0]).

DinnerPlateStacks() ->
    {ok, _} = application:start(kernel),
    {ok, _} = application:start(stdlib),
    {ok, _} = application:start(sasl),
    {ok, _} = application:start(compiler),
    {ok, _} = application:start(runtime_tools),
    {ok, _} = application:start(erts),
    {ok, _} = application:start(mnesia),
    {ok, _} = application:start(inets),
    {ok, _} = application:start(ssh),
    {ok, _} = application:start(ssl),
    {ok, _} = application:start(xmerl),
    {ok, _} = application:start(crypto),
    {ok, _} = application:start(odbc),
    {ok, _} = application:start(wiki),
    {ok, _} = application:start(persistent_term),
    {ok, _} = application:start(compiler).

-record(dinner_plate_stacks, {
    stacks = [],
    total = 0
}).

init() ->
    #dinner_plate_stacks{stacks = []}.

push(stack, plate) ->
    case lists:member(stack, stacks) of
        true -> 
            stacks;
        false -> 
            stacks ++ [stack]
    end,
    total + 1.

pop(stack) ->
    case lists:member(stack, stacks) of
        true -> 
            {ok, NewStacks} = lists:delete(stack, stacks),
            {NewStacks, total - 1};
        false -> 
            {error, "Invalid stack"}
    end.

top(stack) ->
    case lists:member(stack, stacks) of
        true -> 
            hd(stack);
        false -> 
            {error, "Invalid stack"}
    end.