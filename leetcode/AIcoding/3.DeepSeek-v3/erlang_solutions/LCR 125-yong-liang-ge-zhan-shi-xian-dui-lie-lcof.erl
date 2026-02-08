-module(book_queue).
-export([delete_head/1, add_at_tail/2, new/0]).

new() ->
    {[], []}.

add_at_tail(Queue, Value) ->
    {Front, Rear} = Queue,
    {Front, [Value | Rear]}.

delete_head(Queue) ->
    case Queue of
        {[], []} ->
            {-1, {[], []}};
        {[H | T], Rear} ->
            {H, {T, Rear}};
        {[], Rear} ->
            {Front, []} = {lists:reverse(Rear), []},
            {hd(Front), {tl(Front), []}}
    end.