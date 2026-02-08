-module(solution).
-export([isValid/1]).

isValid(Str) ->
    isValid(Str, []).

isValid([], []) ->
    true;
isValid([], _) ->
    false;
isValid([H|T], Stack) ->
    case H of
        '(' -> isValid(T, ['(' | Stack]);
        '[' -> isValid(T, ['[' | Stack]);
        '{' -> isValid(T, ['{' | Stack]);
        ')' ->
            case Stack of
                [H2 | _] when H2 == '(' -> isValid(T, Stack -- [H2]);
                _ -> false
            end;
        ']' ->
            case Stack of
                [H2 | _] when H2 == '[' -> isValid(T, Stack -- [H2]);
                _ -> false
            end;
        '}' ->
            case Stack of
                [H2 | _] when H2 == '{' -> isValid(T, Stack -- [H2]);
                _ -> false
            end
    end.