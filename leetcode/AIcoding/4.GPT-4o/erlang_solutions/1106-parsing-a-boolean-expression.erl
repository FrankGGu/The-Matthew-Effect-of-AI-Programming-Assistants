-module(solution).
-export([parse/1]).

parse(Expression) ->
    parse_expr(lists:reverse(Expression), []).

parse_expr([], Stack) ->
    case Stack of
        [Result] -> Result;
        _ -> false
    end;
parse_expr([H | T], Stack) ->
    case H of
        $t -> parse_expr(T, [true | Stack]);
        $f -> parse_expr(T, [false | Stack]);
        $a -> 
            {A, Rest} = pop(Stack),
            {B, Rest2} = pop(Rest),
            parse_expr(T, [A andalso B | Rest2]);
        $o -> 
            {A, Rest} = pop(Stack),
            {B, Rest2} = pop(Rest),
            parse_expr(T, [A orelse B | Rest2]);
        $n -> 
            {A, Rest} = pop(Stack),
            parse_expr(T, [not A | Rest])
    end.

pop([H | T]) -> {H, T}.