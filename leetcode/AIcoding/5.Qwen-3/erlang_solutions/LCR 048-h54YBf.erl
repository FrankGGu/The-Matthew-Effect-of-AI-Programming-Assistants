-module(serialize_and_deserialize_bst).
-export([serialize/1, deserialize/1]).

-define(NULL, null).

serialize(nil) ->
    [?NULL];
serialize({Val, Left, Right}) ->
    [Val | lists:flatten([serialize(Left), serialize(Right)])].

deserialize([]) ->
    nil;
deserialize([?NULL | T]) ->
    {nil, deserialize(T), deserialize(T)};
deserialize([H | T]) ->
    {H, Left, T1} = split_list(T),
    {H, Left, deserialize(T1)}.

split_list(List) ->
    split_list(List, 0, []).

split_list([], _, Acc) ->
    {nil, lists:reverse(Acc)};
split_list([H | T], Count, Acc) when Count == 0 ->
    case H of
        ?NULL ->
            {nil, lists:reverse(Acc) ++ T};
        _ ->
            split_list(T, 1, [H])
    end;
split_list([H | T], Count, Acc) ->
    split_list(T, Count + 1, [H | Acc]).