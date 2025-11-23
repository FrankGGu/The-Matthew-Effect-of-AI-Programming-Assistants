-module(text_editor).
-export([new/0, addText/2, deleteText/2, cursorLeft/2, cursorRight/2, getText/2]).

new() ->
    {[], []}.

addText({Left, Right}, Text) ->
    {lists:reverse(Text, Left), Right}.

deleteText({Left, Right}, K) ->
    {NewLeft, NewRight} = delete_text(Left, K, Right),
    {NewLeft, NewRight}.

delete_text(Left, 0, Right) ->
    {Left, Right};
delete_text([], _, Right) ->
    {[], Right};
delete_text([_|Rest], K, Right) ->
    delete_text(Rest, K - 1, Right).

cursorLeft({Left, Right}, K) ->
    {NewLeft, NewRight} = cursor_left(Left, K, Right),
    {NewLeft, NewRight}.

cursor_left(Left, 0, Right) ->
    {Left, Right};
cursor_left([], _, Right) ->
    {[], Right};
cursor_left([H|Rest], K, Right) ->
    cursor_left(Rest, K - 1, [H|Right]).

cursorRight({Left, Right}, K) ->
    {NewLeft, NewRight} = cursor_right(Left, K, Right),
    {NewLeft, NewRight}.

cursor_right(Left, 0, Right) ->
    {Left, Right};
cursor_right(Left, _, []) ->
    {Left, []};
cursor_right(Left, K, [H|Rest]) ->
    cursor_right([H|Left], K - 1, Rest).

getText({Left, Right}, K) ->
    ReversedLeft = lists:reverse(Left),
    Sublist = lists:sublist(ReversedLeft, min(K, length(ReversedLeft))),
    list_to_binary(Sublist).