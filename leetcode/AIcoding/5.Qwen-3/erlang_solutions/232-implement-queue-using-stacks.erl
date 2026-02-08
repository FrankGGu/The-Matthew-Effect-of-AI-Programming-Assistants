-module(my_queue).
-export([new/0, push/2, pop/1, peek/1, empty/1]).

new() ->
    {[], []}.

push(Item, {In, Out}) ->
    { [Item | In], Out }.

pop({In, []}) ->
    { lists:reverse(In), [] };
pop({In, [H | T]}) ->
    {In, T}.

peek({In, []}) ->
    lists:last(In);
peek({In, [H | _]}) ->
    H.

empty({In, Out}) ->
    In == [] andalso Out == [].