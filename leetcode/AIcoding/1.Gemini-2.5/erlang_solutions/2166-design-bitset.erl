-module(bitset).
-export([new/1, fix/2, unfix/2, flip/1, all/1, one/1, count/1, to_string/1]).

new(Size) ->
    {Size, gb_sets:new(), false}.

fix(Index, {Size, CurrentSetBits, FlippedState}) ->
    NewSetBits =
        if FlippedState == false ->
            gb_sets:add(Index, CurrentSetBits);
        true ->
            gb_sets:delete(Index, CurrentSetBits)
        end,
    {Size, NewSetBits, FlippedState}.

unfix(Index, {Size, CurrentSetBits, FlippedState}) ->
    NewSetBits =
        if FlippedState == false ->
            gb_sets:delete(Index, CurrentSetBits);
        true ->
            gb_sets:add(Index, CurrentSetBits)
        end,
    {Size, NewSetBits, FlippedState}.

flip({Size, CurrentSetBits, FlippedState}) ->
    {Size, CurrentSetBits, not FlippedState}.

all({Size, CurrentSetBits, FlippedState}) ->
    if FlippedState == false ->
        gb_sets:size(CurrentSetBits) == Size;
    true ->
        gb_sets:size(CurrentSetBits) == 0
    end.

one({Size, CurrentSetBits, FlippedState}) ->
    if FlippedState == false ->
        gb_sets:size(CurrentSetBits) > 0;
    true ->
        gb_sets:size(CurrentSetBits) < Size
    end.

count({Size, CurrentSetBits, FlippedState}) ->
    if FlippedState == false ->
        gb_sets:size(CurrentSetBits);
    true ->
        Size - gb_sets:size(CurrentSetBits)
    end.

to_string({Size, CurrentSetBits, FlippedState}) ->
    Chars =
        lists:map(fun(I) ->
            IsMember = gb_sets:is_member(I, CurrentSetBits),
            if FlippedState == false ->
                if IsMember -> $1; true -> $0 end;
            true ->
                if IsMember -> $0; true -> $1 end
            end
        end, lists:seq(0, Size - 1)),
    lists:flatten(Chars).