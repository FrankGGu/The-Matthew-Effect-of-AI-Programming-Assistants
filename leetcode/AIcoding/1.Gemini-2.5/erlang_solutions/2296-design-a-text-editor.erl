-module(text_editor).
-export([new/0, add_text/2, delete_text/2, cursor_left/2, cursor_right/2]).

new() ->
    {[], []}.

add_text(Text, {LeftReversed, Right}) ->
    %% Text is [t1, t2, ..., tm]
    %% We want to add t1, ..., tm to the left of the cursor.
    %% So LeftReversed should become [tm, ..., t1 | LeftReversed].
    NewLeftReversed = lists:reverse(Text) ++ LeftReversed,
    {NewLeftReversed, Right}.

delete_text(K, {LeftReversed, Right}) ->
    LenLeft = length(LeftReversed),
    ActualDeleted = min(K, LenLeft),
    NewLeftReversed = lists:nthtail(ActualDeleted, LeftReversed),
    {ActualDeleted, {NewLeftReversed, Right}}.

cursor_left(K, {LeftReversed, Right}) ->
    LenLeft = length(LeftReversed),
    ActualMoved = min(K, LenLeft),

    %% Characters to move from LeftReversed to Right
    MovedCharsReversed = lists:sublist(LeftReversed, 1, ActualMoved),
    NewLeftReversed = lists:nthtail(ActualMoved, LeftReversed),

    %% Reverse MovedCharsReversed to get them in normal order, then prepend to Right
    NewRight = lists:reverse(MovedCharsReversed) ++ Right,

    %% Get the last 10 characters to the left of the cursor
    %% These are the first 10 characters of NewLeftReversed (which are reversed)
    ResultStringReversed = lists:sublist(NewLeftReversed, 1, min(10, length(NewLeftReversed))),
    ResultString = lists:reverse(ResultStringReversed),

    {ResultString, {NewLeftReversed, NewRight}}.

cursor_right(K, {LeftReversed, Right}) ->
    LenRight = length(Right),
    ActualMoved = min(K, LenRight),

    %% Characters to move from Right to LeftReversed
    MovedChars = lists:sublist(Right, 1, ActualMoved),
    NewRight = lists:nthtail(ActualMoved, Right),

    %% Reverse MovedChars to get them in reversed order, then prepend to LeftReversed
    NewLeftReversed = lists:reverse(MovedChars) ++ LeftReversed,

    %% Get the last 10 characters to the left of the cursor
    %% These are the first 10 characters of NewLeftReversed (which are reversed)
    ResultStringReversed = lists:sublist(NewLeftReversed, 1, min(10, length(NewLeftReversed))),
    ResultString = lists:reverse(ResultStringReversed),

    {ResultString, {NewLeftReversed, NewRight}}.