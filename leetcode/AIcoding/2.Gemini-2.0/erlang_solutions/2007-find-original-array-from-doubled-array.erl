-module(find_original_array).
-export([find_original_array/1]).

find_original_array(Changed) ->
    case length(Changed) rem 2 of
        0 ->
            {ok, Original} = find_original_array_helper(Changed, []),
            Original;
        _ ->
            []
    end.

find_original_array_helper([], Acc) ->
    {ok, lists:reverse(Acc)};
find_original_array_helper(Changed, Acc) ->
    Sorted = lists:sort(Changed),
    case find_match(hd(Sorted), Sorted) of
        {ok, Rest} ->
            find_original_array_helper(Rest, [hd(Sorted) | Acc]);
        _ ->
            {error, []}
    end.

find_match(X, [X|T]) ->
    case lists:member(2*X, T) of
        true ->
            {ok, remove(2*X, T)};
        false ->
            {error, []}
    end.

remove(X, [X|T]) ->
    T;
remove(X, [H|T]) ->
    [H|remove(X, T)].