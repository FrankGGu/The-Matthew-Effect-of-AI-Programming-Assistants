-module(remove_methods).
-export([remove_methods/1]).

remove_methods(SourceCode) ->
    remove_methods_helper(SourceCode, []).

remove_methods_helper([], Acc) ->
    lists:reverse(Acc);
remove_methods_helper([H|T], Acc) ->
    case is_method_start(H) of
        true ->
            {Rest, _} = remove_method(T, 1),
            remove_methods_helper(Rest, Acc);
        false ->
            remove_methods_helper(T, [H|Acc])
    end.

is_method_start(Line) ->
    case string:str(Line, "(") > 0 andalso string:str(Line, ")") > 0 of
        true ->
            not lists:member(Line, ["{", "}"]);
        false ->
            false
    end.

remove_method([], Depth) ->
    {[], Depth};
remove_method([H|T], Depth) ->
    case string:str(H, "{") > 0 of
        true ->
            remove_method(T, Depth + 1);
        false ->
            case string:str(H, "}") > 0 of
                true ->
                    if Depth =:= 1 ->
                        {T, Depth - 1};
                    true ->
                        remove_method(T, Depth - 1)
                    end;
                false ->
                    remove_method(T, Depth)
            end
    end.