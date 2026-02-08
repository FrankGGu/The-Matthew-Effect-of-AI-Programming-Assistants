-module(solution).
-export([makeFancyString/1]).

makeFancyString(S) ->
    make_fancy_string_acc(S, [], 0, []).

make_fancy_string_acc([], _PrevChar, _ConsecCount, Acc) ->
    lists:reverse(Acc);

make_fancy_string_acc([H|T], [], _ConsecCount, Acc) ->
    make_fancy_string_acc(T, H, 1, [H|Acc]);

make_fancy_string_acc([H|T], PrevChar, ConsecCount, Acc) when H == PrevChar ->
    NewConsecCount = ConsecCount + 1,
    if NewConsecCount < 3 ->
        make_fancy_string_acc(T, H, NewConsecCount, [H|Acc]);
    true -> % NewConsecCount is 3 or more, so skip H
        make_fancy_string_acc(T, H, NewConsecCount, Acc)
    end;

make_fancy_string_acc([H|T], _PrevChar, _ConsecCount, Acc) ->
    make_fancy_string_acc(T, H, 1, [H|Acc]).