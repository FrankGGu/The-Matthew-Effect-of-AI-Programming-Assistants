-module(solution).
-export([next_greater_element/1]).

next_greater_element(N) ->
    Digits = integer_to_list(N),
    Next = next_permutation(Digits),
    case Next of
        undefined -> -1;
        _ -> list_to_integer(Next)
    end.

next_permutation([]) -> undefined;
next_permutation(List) ->
    {Prefix, Suffix} = split_at(List, length(List) - 1),
    case find_greater(Prefix) of
        {NewPrefix, SwapIndex} ->
            NewSuffix = lists:sort(append(tl(Prefix), lists:nth(SwapIndex + 1, Suffix))),
            lists:concat([NewPrefix, [lists:nth(SwapIndex + 1, Suffix)] | NewSuffix]);
        undefined -> undefined
    end.

find_greater(List) ->
    case lists:foldl(fun(X, {Prev, Index, Res}) ->
        case Prev < X of
            true -> {X, Index, lists:append(Res, [Prev])};
            false -> {X, Index + 1, [X | Res]}
        end
    end, {hd(List), 1, []}, tl(List)) of
        {_, _, Res} when length(Res) > 0 -> {lists:reverse(Res), length(List) - length(Res)};
        _ -> undefined
    end.

split_at(List, N) ->
    lists:split(N, List).