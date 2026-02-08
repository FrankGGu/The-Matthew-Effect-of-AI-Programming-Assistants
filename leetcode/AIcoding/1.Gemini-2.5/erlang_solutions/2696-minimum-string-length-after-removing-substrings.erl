-module(solution).
-export([min_length/1]).

-spec min_length(S :: unicode:unicode_binary() | unicode:unicode_list()) -> integer().
min_length(S) ->
    min_length_acc(unicode:characters_to_list(S), []).

min_length_acc([], Stack) ->
    length(Stack);
min_length_acc([H|T], []) ->
    min_length_acc(T, [H]);
min_length_acc([H|T], [SH|ST]) when (H == $B andalso SH == $A) orelse (H == $D andalso SH == $C) ->
    min_length_acc(T, ST);
min_length_acc([H|T], Stack) ->
    min_length_acc(T, [H|Stack]).