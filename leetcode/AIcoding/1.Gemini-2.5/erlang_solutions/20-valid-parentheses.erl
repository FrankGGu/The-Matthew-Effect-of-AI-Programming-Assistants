-module(solution).
-export([isValid/1]).

isValid(S) ->
    isValid_recursive(S, []).

isValid_recursive([], []) ->
    true;
isValid_recursive([], _Stack) ->
    false;
isValid_recursive([Char|Rest], Stack) ->
    case Char of
        $( -> isValid_recursive(Rest, [Char|Stack]);
        ${ -> isValid_recursive(Rest, [Char|Stack]);
        $[ -> isValid_recursive(Rest, [Char|Stack]);
        $) ->
            case Stack of
                [$ (|RestStack] ->
                    isValid_recursive(Rest, RestStack);
                _ ->
                    false
            end;
        $} ->
            case Stack of
                [${|RestStack] ->
                    isValid_recursive(Rest, RestStack);
                _ ->
                    false
            end;
        $] ->
            case Stack of
                [$[|RestStack] ->
                    isValid_recursive(Rest, RestStack);
                _ ->
                    false
            end;
        _ ->
            false
    end.