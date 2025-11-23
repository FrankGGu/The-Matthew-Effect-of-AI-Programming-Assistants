-module(solution).
-export([can_form_array/2]).

can_form_array(Items, Pairs) ->
    can_form_array(Items, Pairs, []).

can_form_array([], _, _) ->
    true;
can_form_array(Items, Pairs, Acc) ->
    case find_next(Items, Pairs) of
        false ->
            false;
        {Pair, Remaining} ->
            can_form_array(Remaining, Pairs, [Pair | Acc])
    end.

find_next(Items, Pairs) ->
    find_next(Items, Pairs, 0).

find_next(Items, Pairs, Index) ->
    case lists:keysearch(hd(Items), 1, Pairs) of
        false ->
            false;
        {value, {First, Second}} ->
            case lists:prefix([First, Second], Items) of
                true ->
                    { {First, Second}, tl(tl(Items)) };
                false ->
                    find_next(Items, Pairs, Index + 1)
            end
    end.