-module(remove_element).
-export([remove_element/2]).

remove_element(_, []) ->
    0;
remove_element(Value, [H|T]) ->
    if
        H == Value ->
            remove_element(Value, T);
        true ->
            1 + remove_element(Value, T)
    end.