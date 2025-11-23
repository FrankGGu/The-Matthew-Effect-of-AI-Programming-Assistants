-module(mergeKLists).
-export([mergeKLists/1]).

mergeKLists(Lists) ->
    mergeLists(Lists, []).

mergeLists([], Acc) ->
    reverse(Acc);
mergeLists([H | T], Acc) ->
    case H of
        [] ->
            mergeLists(T, Acc);
        _ ->
            {Min, Rest} = findMin(H, T, H, []),
            mergeLists(Rest, [Min | Acc])
    end.

findMin([], Rest, Min, Acc) ->
    {Min, Rest};
findMin([H | T], Rest, Min, Acc) ->
    case H < element(1, Min) of
        true ->
            findMin(T, Rest, {H, [element(1, Min) | element(2, Min)]}, [Acc | Rest]);
        false ->
            findMin(T, Rest, Min, [H | Acc])
    end.

reverse(List) ->
    reverse(List, []).

reverse([], Acc) ->
    Acc;
reverse([H | T], Acc) ->
    reverse(T, [H | Acc]).

element(1, {H, _}) ->
    H;
element(2, {_, T}) ->
    T.