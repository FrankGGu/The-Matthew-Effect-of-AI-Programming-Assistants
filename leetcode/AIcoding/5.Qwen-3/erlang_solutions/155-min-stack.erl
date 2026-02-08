-module(min_stack).
-export([new/0, push/2, pop/1, top/1, get_min/1]).

new() ->
    {[], []}.

push(Stack, Value) ->
    Min = case Stack of
              {[], _} -> Value;
              {_, [MinVal | _]} -> min(Value, MinVal)
          end,
    { [Value | element(1, Stack)], [Min | element(2, Stack)] }.

pop({[ _ | T1 ], [ _ | T2 ]}) ->
    {T1, T2}.

top({[H | _], _}) ->
    H.

get_min({_ , [M | _]}) ->
    M.