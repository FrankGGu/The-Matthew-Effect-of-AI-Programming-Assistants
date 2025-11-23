-module(text_editor).
-export([new/0, add_text/2, delete_text/2, cursor_left/1, cursor_right/1, get_text/1]).

-record(editor, {left = [], right = []}).

new() ->
    #editor{}.

add_text(#editor{left = Left, right = Right} = Editor, Text) ->
    NewLeft = lists:append(Left, Text),
    Editor#editor{left = NewLeft, right = Right}.

delete_text(#editor{left = Left, right = Right} = Editor, K) ->
    if
        length(Left) >= K ->
            {Deleted, NewLeft} = lists:split(length(Left) - K, Left),
            Editor#editor{left = NewLeft, right = [lists:reverse(Deleted) | Right]};
        true ->
            {Deleted, NewLeft} = lists:split(0, Left),
            Editor#editor{left = NewLeft, right = [lists:reverse(Deleted) | Right]}
    end.

cursor_left(#editor{left = Left, right = Right} = Editor, K) ->
    if
        length(Left) >= K ->
            {Moved, NewLeft} = lists:split(length(Left) - K, Left),
            Editor#editor{left = NewLeft, right = [lists:reverse(Moved) | Right]};
        true ->
            {Moved, NewLeft} = lists:split(0, Left),
            Editor#editor{left = NewLeft, right = [lists:reverse(Moved) | Right]}
    end.

cursor_right(#editor{left = Left, right = Right} = Editor, K) ->
    if
        length(Right) >= K ->
            {Moved, NewRight} = lists:split(K, Right),
            Editor#editor{left = lists:append(Left, lists:reverse(Moved)), right = NewRight};
        true ->
            {Moved, NewRight} = lists:split(length(Right), Right),
            Editor#editor{left = lists:append(Left, lists:reverse(Moved)), right = NewRight}
    end.

get_text(#editor{left = Left, right = Right}) ->
    lists:append(Left, lists:reverse(Right)).