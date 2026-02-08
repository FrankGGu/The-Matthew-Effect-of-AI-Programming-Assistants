-module(circular_array_loop).
-export([circular_array_loop/1]).

circular_array_loop(Nums) ->
    Len = length(Nums),
    lists:any(fun(I) -> has_cycle(Nums, I, Len) end, lists:seq(0, Len - 1)).

has_cycle(Nums, Start, Len) ->
    case find_loop(Nums, Start, Len, Start, []) of
        {true, _} -> true;
        _ -> false
    end.

find_loop(Nums, Curr, Len, Start, Visited) ->
    Val = lists:nth(Curr + 1, Nums),
    Next = (Curr + Val) rem Len,
    if Next < 0 ->
        Next1 = Next + Len
    else
        Next1 = Next
    end,

    if Next1 == Curr ->
        {false, []};

    (lists:member(Curr, Visited) and (Val rem Len) * (lists:nth(Start + 1, Nums) rem Len) > 0) ->
        {true, Visited};

    (Val rem Len) * (lists:nth(Start + 1, Nums) rem Len) < 0 ->
        {false, []};

    lists:member(Next1, Visited) ->
        if Next1 == Start ->
            {true, Visited}
        else
            {false, []}
        end;

    true ->
        find_loop(Nums, Next1, Len, Start, [Curr | Visited])
    end.