-module(solution).
-export([evaluate/1]).

evaluate(S) ->
    evaluate(S, []).

evaluate([], Stack) ->
    Stack;
evaluate([H | T], Stack) ->
    case H of
        $'(' -> evaluate(T, [H | Stack]);
        $')' ->
            case find_matching('(', Stack) of
                {ok, NewStack} -> evaluate(T, NewStack);
                error -> error
            end;
        _ -> evaluate(T, Stack)
    end.

find_matching(_, []) -> error;
find_matching(Char, [H | T]) ->
    if 
        H == Char -> {ok, T};
        true -> find_matching(Char, T)
    end.