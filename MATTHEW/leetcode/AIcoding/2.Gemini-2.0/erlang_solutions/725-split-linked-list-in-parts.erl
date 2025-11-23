-module(split_list_to_parts).
-export([split_list_to_parts/2]).

split_list_to_parts(Head, K) ->
    Len = list_length(Head),
    Width = Len div K,
    Remainder = Len rem K,
    split_list(Head, K, Width, Remainder, []).

split_list(Head, 0, _, _, Acc) ->
    lists:reverse(Acc);
split_list(Head, K, Width, Remainder, Acc) ->
    case Head of
        [] ->
            split_list([], K - 1, Width, 0, [[] | Acc]);
        _ ->
            case Remainder > 0 of
                true ->
                    {Part, Rest} = split(Head, Width + 1),
                    split_list(Rest, K - 1, Width, Remainder - 1, [Part | Acc]);
                false ->
                    {Part, Rest} = split(Head, Width),
                    split_list(Rest, K - 1, Width, Remainder, [Part | Acc])
            end
    end.

split(Head, N) ->
    split(Head, N, [], Head).

split([], _, Acc, _) ->
    {lists:reverse(Acc), []};
split(_, 0, Acc, Head) ->
    {lists:reverse(Acc), Head};
split([H | T], N, Acc, _) ->
    split(T, N - 1, [H | Acc], _).

list_length(List) ->
    list_length(List, 0).

list_length([], Acc) ->
    Acc;
list_length([_ | T], Acc) ->
    list_length(T, Acc + 1).