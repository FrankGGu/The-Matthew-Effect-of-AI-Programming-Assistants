-module(stack).
-export([new/0, push/2, pop/1, top/1, empty/1]).

new() ->
    {queue, []}.

push(Item, {queue, Q}) ->
    {queue, [Item | Q]}.

pop({queue, [H | T]}) ->
    {H, {queue, T}};
pop({queue, []}) ->
    error.

top({queue, [H | _]}) ->
    H;
top({queue, []}) ->
    error.

empty({queue, []}) ->
    true;
empty(_) ->
    false.