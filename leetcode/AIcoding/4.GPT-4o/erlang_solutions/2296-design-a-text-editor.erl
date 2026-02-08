-module(text_editor).
-export([new/0, add_text/2, delete_text/2, cursor_left/2, cursor_right/2, get_text/1]).

-record(state, {text = "", cursor = 0}).

new() ->
    #state{}.

add_text(State, Text) ->
    Cursor = State#state.cursor,
    NewText = lists:insert_at(Cursor, Text, State#state.text),
    NewCursor = Cursor + length(Text),
    State#state{text = NewText, cursor = NewCursor}.

delete_text(State, K) ->
    Cursor = State#state.cursor,
    NewCursor = max(Cursor - K, 0),
    NewText = lists:sublist(State#state.text, 1, NewCursor) ++
              lists:sublist(State#state.text, Cursor + 1),
    State#state{text = NewText, cursor = NewCursor}.

cursor_left(State, K) ->
    NewCursor = max(State#state.cursor - K, 0),
    State#state{State#state | cursor = NewCursor}.

cursor_right(State, K) ->
    NewCursor = min(State#state.cursor + K, length(State#state.text)),
    State#state{State#state | cursor = NewCursor}.

get_text(State) ->
    State#state.text.