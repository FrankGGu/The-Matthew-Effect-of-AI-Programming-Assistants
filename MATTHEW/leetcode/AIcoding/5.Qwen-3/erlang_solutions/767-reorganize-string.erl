-module(reorganize_string).
-export([reorganize/1]).

reorganize(S) ->
    Len = length(S),
    Count = count_chars(S),
    Max = lists:max([V || {_, V} <- Count]),
    if
        Max > (Len + 1) div 2 -> [];
        true -> build_string(Count, Len)
    end.

count_chars(S) ->
    count_chars(S, #{}).

count_chars([], Acc) ->
    Acc;
count_chars([C | T], Acc) ->
    NewAcc = case maps:is_key(C, Acc) of
        true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
        false -> maps:put(C, 1, Acc)
    end,
    count_chars(T, NewAcc).

build_string(Count, Len) ->
    build_string(Count, [], Len).

build_string(_, Result, 0) ->
    lists:reverse(Result);
build_string(Count, Result, _Len) ->
    {Char, Count1} = select_char(Count),
    build_string(Count1, [Char | Result], Len - 1).

select_char(Count) ->
    Lists = maps:to_list(Count),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Lists),
    [{Char, Count}] = Sorted,
    {Char, maps:remove(Char, Count)}.

reorganize([]) -> [];
reorganize(_) -> [].