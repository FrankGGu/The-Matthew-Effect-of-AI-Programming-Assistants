-module(text_editor).
-export([init/0, addText/2, deleteText/1, cursorLeft/2, cursorRight/2, getText/1]).

-record(editor, {left = [], right = []}).

init() ->
    #editor{}.

addText(Text, Editor) ->
    Left = Editor#editor.left ++ Text,
    Editor#editor{left = Left}.

deleteText(K, Editor) ->
    Left = Editor#editor.left,
    Len = length(Left),
    Deleted = min(K, Len),
    NewLeft = lists:sublist(Left, 1, Len - Deleted),
    Editor#editor{left = NewLeft}.

cursorLeft(K, Editor) ->
    Left = Editor#editor.left,
    Right = Editor#editor.right,
    Len = length(Left),
    Move = min(K, Len),
    {LeftPart, RightPart} = lists:split(Len - Move, Left),
    NewLeft = LeftPart,
    NewRight = RightPart ++ Right,
    Editor#editor{left = NewLeft, right = NewRight}.

cursorRight(K, Editor) ->
    Left = Editor#editor.left,
    Right = Editor#editor.right,
    Len = length(Right),
    Move = min(K, Len),
    {LeftPart, RightPart} = lists:split(Move, Right),
    NewLeft = Left ++ LeftPart,
    NewRight = RightPart,
    Editor#editor{left = NewLeft, right = NewRight}.

getText(Editor) ->
    Left = Editor#editor.left,
    Right = Editor#editor.right,
    Left ++ Right.